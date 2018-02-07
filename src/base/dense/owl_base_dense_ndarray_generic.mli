(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(**
N-dimensional array module: including creation, manipulation, and various
vectorised mathematical operations.
*)

(**
About the comparison of two complex numbers ``x`` and ``y``, Owl uses the
following conventions: 1) ``x`` and ``y`` are equal iff both real and imaginary
parts are equal; 2) ``x`` is less than ``y`` if the magnitude of ``x`` is less than
the magnitude of ``x``; in case both ``x`` and ``y`` have the same magnitudes, ``x``
is less than ``x`` if the phase of ``x`` is less than the phase of ``y``; 3) less or
equal, greater, greater or equal relation can be further defined atop of the
aforementioned conventions.
*)

open Bigarray

open Owl_types


(** {6 Type definition} *)

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

type ('a, 'b) kind = ('a, 'b) Bigarray.kind
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Create Ndarrays}  *)

val empty : ('a, 'b) kind -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


val create : ('a, 'b) kind -> int array -> 'a -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val init : ('a, 'b) kind -> int array -> (int -> 'a) -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val zeros : ('a, 'b) kind -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val ones : ('a, 'b) kind -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val uniform : (float, 'b) kind -> ?a:float -> ?b:float -> int array -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val gaussian : (float, 'b) kind -> ?mu:float -> ?sigma:float -> int array -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sequential : (float, 'b) kind -> ?a:float -> ?step:float -> int array -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a  (except p) *)
val bernoulli : (float, 'b) kind -> ?p:float -> int array -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(** {6 Obtain basic properties}  *)

val shape : ('a, 'b) t -> int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val num_dims : ('a, 'b) t -> int
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val numel : ('a, 'b) t -> int
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val kind : ('a, 'b) t -> ('a, 'b) kind
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Manipulate Ndarrays}  *)

val get : ('a, 'b) t -> int array -> 'a
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val set : ('a, 'b) t -> int array -> 'a -> unit
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val get_slice : int list list -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val set_slice : int list list -> ('a, 'b) t -> ('a, 'b) t -> unit
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val reset : (float, 'b) t -> unit
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val copy : ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val reshape : ('a, 'b) t -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val flatten : ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val reverse : ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val transpose : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val tile : ('a, 'b) t -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val repeat : ?axis:int -> ('a, 'b) t -> int -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val concatenate : ?axis:int -> ('a, 'b) t array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val split : ?axis:int -> int array -> ('a, 'b) t -> ('a, 'b) t array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val draw : ?axis:int -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(** {6 Iterate array elements}  *)

val map : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Examination & Comparison}  *)

val equal : (float, 'b) t -> (float, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a (except for eps) *)
val approx_equal : ?eps:float -> (float, 'b) t -> (float, 'b) t -> bool
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val elt_equal : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val elt_greater_equal_scalar : (float, 'b) t -> float -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Input/Output functions}  *)

val of_array : ('a, 'b) kind -> 'a array -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:('a -> string) -> ('a, 'b) t -> unit
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val load : ('a, 'b) kind -> string -> ('a, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Unary math operators }  *)

(* TODO: change float to 'a *)
val sum : ?axis:int -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sum' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val min' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val max' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val abs : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val neg : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val signum : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sqr : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sqrt : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val exp : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val log : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val log10 : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val log2 : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sin : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val cos : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val tan : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val asin : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val acos : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val atan : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sinh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val cosh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val tanh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val asinh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val acosh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val atanh : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val floor : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val ceil : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val round : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val relu : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val sigmoid : (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val l1norm' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val l2norm' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val l2norm_sqr' : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Binary math operators}  *)

(* TODO: change float to 'a *)
val add : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sub : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val mul : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val div : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val add_scalar : (float, 'b) t -> float -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val sub_scalar : (float, 'b) t -> float -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val mul_scalar : (float, 'b) t -> float -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val div_scalar : (float, 'b) t -> float -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val scalar_add : float -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val scalar_sub : float -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val scalar_mul : float -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val scalar_div : float -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val pow : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val scalar_pow : float -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val pow_scalar : (float, 'b) t -> float -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val atan2 : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val scalar_atan2 : float -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val atan2_scalar : (float, 'a) t -> float -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

(* TODO: change float to 'a *)
val clip_by_value : ?amin:float -> ?amax:float -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val clip_by_l2norm : float -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Neural network related}  *)

val conv1d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv2d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv3d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool1d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool2d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool3d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool1d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool2d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool3d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv1d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv1d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv2d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv2d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv3d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val conv3d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool1d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val max_pool2d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool1d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)

val avg_pool2d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Helper functions }  *)

(* TODO: change float to 'a *)
val sum_slices : ?axis:int -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_ndarray_generic` *)


(** {6 Matrix functions}  *)

val row_num : ('a, 'b) t -> int
(** Refer to :doc:`owl_dense_matrix_generic` *)

val col_num : ('a, 'b) t -> int
(** Refer to :doc:`owl_dense_matrix_generic` *)

val row : ('a, 'b) t -> int -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val rows : ('a, 'b) t -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val copy_row_to : ('a, 'b) t -> ('a, 'b) t -> int -> unit
(** Refer to :doc:`owl_dense_matrix_generic` *)

val copy_col_to : ('a, 'b) t -> ('a, 'b) t -> int -> unit
(** Refer to :doc:`owl_dense_matrix_generic` *)

(* TODO: change float to 'a *)
val dot : (float, 'b) t -> (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

(* TODO: change float to 'a *)
val inv : (float, 'b) t -> (float, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val trace : (float, 'b) t -> float
(** Refer to :doc:`owl_dense_matrix_generic` *)

val to_rows : ('a, 'b) t -> ('a, 'b) t array
(** Refer to :doc:`owl_dense_matrix_generic` *)

val of_rows : ('a, 'b) t array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val of_arrays : ('a, 'b) kind -> 'a array array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val draw_rows : ?replacement:bool -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_matrix_generic` *)

val draw_rows2 : ?replacement:bool -> ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t * ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_matrix_generic` *)



(* ends here *)