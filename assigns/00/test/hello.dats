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

extern
fun
intlist_append : (intlist, intlist) -> intlist
//

implement
intlist_append(
    l1: intlist, l2: intlist
): intlist = let
fun
loop(
    l1_mod: intlist, l_append_reverse: intlist, l_append: intlist
): intlist =
(
    case l1_mod of
    | intlist_nil() => l_append
    | intlist_cons(x1, xs) => 
    (
        case l_append_reverse of
        | intlist_nil() => l_append
        | intlist_cons(x2, xm) => loop(xs, xm, x2 :: l_append)
    )
)
fun
loop_reverse(
    l1_mod: intlist, l_append_reverse: intlist
): intlist = 
(
    case l1_mod of
    | intlist_nil() => loop(l1, l_append_reverse, l2)
    | intlist_cons(x1, xs) => loop_reverse(xs, x1 :: l_append_reverse)
)
in
    loop_reverse(l1, l2)
end

val test = intlist_append(l1, l2)
val () = println!(test)

(*
val () = println!(test)
*)

implement main() = 0
