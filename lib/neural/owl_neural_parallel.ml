(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Experimental module, do not use now *)

open Owl_neural
open Owl_algodiff.S


(* module signature of model parallel engine *)

module type EngineSig = sig

  type param_context
  type barrier = ASP | BSP | SSP | PSP

  (* functions to hook into parameter server *)

  val get : 'a -> 'b * int

  val set : 'a -> 'b -> unit

  val start : ?barrier:barrier -> string -> string -> unit

  val register_barrier : (param_context ref -> int * (string list)) -> unit

  val register_schedule : ('a list -> ('a * ('b * 'c) list) list) -> unit

  val register_pull : (('a * 'b) list -> ('a * 'c) list) -> unit

  val register_push : ('a -> ('b * 'c) list -> ('b * 'c) list) -> unit

  val register_stop : (param_context ref -> bool) -> unit

end


(* module signature of neural network model *)

module type ModelSig = sig

  type network

  val mkpar : network -> t array array

  val init : network -> unit

  val update : network -> t array array -> unit

  val train_generic : ?params:Params.typ -> ?init_model:bool -> network -> t -> t -> float array

end


(* implementation of parallel neural network training *)

module Make (E : EngineSig) (M : ModelSig) = struct

  type task = {
    mutable params : Params.typ;
    mutable model  : M.network;
    mutable data_x : t;
    mutable data_y : t;
  }


  let make_task params model data_x data_y = {
    params;
    model;
    data_x;
    data_y;
  }


  (* calculate \delta model = model1 - model0, save the result in model0 *)
  let delta_model model1 model0 =
    let par0 = M.mkpar model0 in
    let par1 = M.mkpar model1 in
    let delta = Owl_utils.aarr_map2 (fun a0 a1 -> Maths.(a0 - a1)) par0 par1 in
    M.update model0 delta


  (* retrieve local model at parameter server, init if none *)
  let local_model task =
    try E.get "model" |> fst
    with Not_found -> (
      Log.warn "set up first model";
      M.init task.model;
      E.set "model" task.model;
      E.get "model" |> fst;
    )


  let schedule task workers =
    (* get model, if none then init locally *)
    let model = local_model task in
    let tasks = List.map (fun x ->
      (x, [("model", model)])
    ) workers
    in tasks


  let pull task vars =
    (* FIXME: average over number of workers *)
    let n = 2. in
    let w_old = F ((n -. 1.) /. n) in
    let w_new = F (1. /. n) in
    (* there should be only one item in list *)
    List.map (fun (k, model1) ->
      let model0 = local_model task in
      let par0 = M.mkpar model0 in
      let par1 = M.mkpar model1 in
      Owl_utils.aarr_map2 (fun a0 a1 ->
        (* DEBUG *)
        (*
        (match a0 with
        | F x   -> Printf.printf "a0 : f\t"
        | Mat x -> let s = a0 |> shape |> Owl_utils.string_of_array string_of_int in Printf.printf "a0 : m %s\t" s
        | Arr x -> Printf.printf "a0 : a\t");
        (match a1 with
        | F x   -> Printf.printf "a1 : f\t"
        | Mat x -> let s = a1 |> shape |> Owl_utils.string_of_array string_of_int in Printf.printf "a1 : m %s\t" s
        | Arr x -> Printf.printf "a1 : a\t");
        print_endline "";
        flush_all();
        *)
        Maths.(w_old * a0 + w_new * a1)
      ) par0 par1
      |> M.update model0;
      task.model <- model0;
      E.set "model" task.model;
      (k, model0)
    ) vars


  let push task id vars =
    (* there should be only one item in list *)
    let updates = List.map (fun (k, model) ->
      task.model <- model;
      (* start local training *)
      let params = task.params in
      let x = task.data_x in
      let y = task.data_y in
      M.train_generic ~params ~init_model:false model x y |> ignore;
      (* TODO: only send out delta model in future *)
      (k, model) ) vars in
    updates


  let train ?params nn x y jid url =
    (* prepare params and make task *)
    let params = match params with
      | Some p -> p
      | None   -> Params.default ()
    in
    let task = make_task params nn x y in
    (* register sched/push/pull/barrier fun *)
    E.register_schedule (schedule task);
    E.register_pull (pull task);
    E.register_push (push task);
    E.start ~barrier:E.ASP jid url

end