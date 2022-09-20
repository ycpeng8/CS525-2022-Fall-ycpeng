#include "share/atspre_staload.hats"
#staload "./../assign00.dats"

(* ****** ****** *)
(*
** 
** Finding the number
** of bits in int-values
**
*)
(* ****** ****** *)
//
(*
HX: Sample
factorial(n) = 1*2*...*n
*)
//

implement factorial(
    n: int
): int = let
fun 
loop(n: int): int =
    if n > 0 then (n+1) * loop(n-1) else 1
in
    loop(n-1)
end

(* test *)
val facto = factorial(5)
val () = println!("factorial(5) = ", facto)

//
(* ****** ****** *)
//
// HX: 5 points
// The function int_test should
// return the size of an integer in C
// where the size means the number of bits.
// Note that you should only use comparison
// and addition in the implementation of the
// following function [int_test].
//

fun 
out_2(
    n: int
): int = let
fun
loop(n: int): int =
    if n >= 0 then 2 * loop(n-1) else 1
in
    loop(n-1)
end


implement
int_test(): int = let
fun
loop(n: int): int = 
    if out_2(n) != 0 then loop(n+1) else n - 1
in
    loop(0)
end

(* 
The reason why we plus 1 is to include the bit which handles positive and negative.
*)
val int_size = int_test() + 1

(* test *)
val () = println!("the size of the integer: ", int_size)

    
//
(* ****** ****** *)
//
// HX: 10 points
// The function [gheep] is defined as follows:
//
fun ghaap(n: int): int =
(
  if
  (n >= 2)
  then n * ghaap(n-1) * ghaap(n-2)
  else (n+1)
  // end of [if]
)
//
// Please implement a tail-recursive function gheep
// such thats gheep(n) = ghaap(n) for all integers n
//

implement 
gheep(
    n: int
): int = let
fun
loop(
    iter: int, prev1: int, prev2: int
): int = 
(
    if (iter < n)
    then loop(iter+1, iter*prev1*prev2, prev1)
    else n*prev1*prev2
)
in
    if (n >= 2)
    then loop(2, 2, 1)
    else (n+1)
end

(* test *)
val () = println!("ghaap(4): ", ghaap(4))
val () = println!("gheep(4): ", gheep(4))


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

overload print with print_intlst
overload fprint with fprint_intlst
//
(* ****** ****** *)
//
// HX: 15 points
//
// intlist_append returns the concatenation
// of two given integer lists. For instance,
// given xs=(0,2,4) and ys = (1,3,5), then the
// returned list is (0, 2, 4, 1, 3, 5)
// Please give a tail-recursive implementation
// of intlist_append.
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

(* test *)
val l1 = 0 :: 2 :: 4 :: nil()
val l2 = 1 :: 3 :: 5 :: nil()
val () = println!("l1 = ", l1)
val () = println!("l2 = ", l2)
val () = println!("l_append = ", intlist_append(l1, l2))
(* ****** ****** *)

(* end of [CS525-2022-Fall/assigns/assign00.dats] *)


(* test *)
implement main() = 0
