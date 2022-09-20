#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
(*
#staload "./../../../mylib/mylib.dats"
*)

datatype
intlist =
|
intlist_nil of ()
|
intlist_cons of (int, intlist)
//
#define nil intlist_nil
#define :: intlist_cons
#define cons intlist_cons

fun
fprint_intlst
(out: FILEref, xs: intlist): void =
(
case xs of
| intlist_nil() =>
  fprint_string(out, "nil()")
| intlist_cons(x1, xs) =>
(
  fprint_string(out, "cons(");
  fprint_int(out, x1); fprint_string(out, ";");
  fprint_intlst(out, xs); fprint_string(out, ")")
)
)

fun
print_intlst
(xs: intlist): void =
fprint_intlst(stdout_ref, xs)

(* ****** ****** *)

overload print with print_intlst
overload fprint with fprint_intlst

(*
val l1 = 0 :: 2 :: 4 :: nil()
val l2 = 1 :: 3 :: 5 :: nil()
*)

val l1 = 0 :: 2 :: 4 :: 9 :: 2 :: nil()
val l2 = 1 :: 3 :: 5 :: nil()

val intlist_cons(x1, xs) = l1
val () = println!(x1)
val () = println!(xs)

implement main() = 0
