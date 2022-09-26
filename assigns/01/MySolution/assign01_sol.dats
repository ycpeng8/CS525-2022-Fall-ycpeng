// #staload "./../assign01.dats"
#include
"share/atspre_staload.hats"
#staload "./../../../mylib/mylib.dats"
#include
"./../../..\
/lectures/lecture-09-14/lambda0.dats"

(* ****** ****** *)
//                                   
typedef
tvarset = mylist(tvar)

extern
fun FV(t0: term): tvarset

extern
fun // empty set
tvarset_nil(): tvarset

extern
fun // singleton set
tvarset_sing(v0: tvar): tvarset

extern
fun // delete an element from a set
tvarset_del1(tvarset, tvar): tvarset

extern
fun // form the union of two given sets
tvarset_union(tvarset, tvarset): tvarset


(* ****** ****** *)
(*
empty set
*)
implement 
tvarset_nil() =
mylist_nil()
(* ****** ****** *)

(* ****** ****** *)
(*
singleton set
*)
implement 
tvarset_sing(v0: tvar)=
mylist_sing(v0)
(* ****** ****** *)

(* ****** ****** *)
(*
delete an element from a set
*)
implement
tvarset_del1(
    t0: tvarset, v0: tvar
): tvarset= let 
fun 
loop(
    t0: tvarset
): tvarset = 
(
    case t0 of
    | mylist_nil() => mylist_nil()
    | mylist_cons(v1, t1) => 
    (
        if v1 = v0
        then loop(t1)
        else mylist_cons(v1, loop(t1))
    )
)
in
    loop(t0)
end
(* ****** ****** *)

(* ****** ****** *)
(*
form the union of two given sets
*)
implement
tvarset_union(
    t0: tvarset, t1: tvarset
): tvarset= let
    fun
    merge_sort(
        t: tvarset
    ): tvarset=let
        fun
        merge(
            left: tvarset, right: tvarset
        ): tvarset=
        (
            case (left, right) of
            | (mylist_nil(), right) => right
            | (left, mylist_nil()) => left
            | (mylist_cons(x1, xs), mylist_cons(y1, ys)) =>
            if x1 < y1
            then mylist_cons(x1, merge(xs, right))
            else if x1 = y1
            then mylist_cons(x1, merge(xs, ys))
            else mylist_cons(y1, merge(left, ys))
        )
        fun split_left(
            n: int, t: tvarset
        ): tvarset=
        (
            case t of
            | mylist_nil() => mylist_nil()
            | mylist_cons(x1, xs) => (
                if n <= 0
                then mylist_nil()
                else mylist_cons(x1, split_left(n-1, xs))
            )
        )
        fun split_right(
            n: int, t: tvarset
        ): tvarset=
        (
            case t of
            | mylist_nil() => mylist_nil()
            | mylist_cons(x1, xs) => (
                if n <= 0
                then t
                else split_right(n-1, xs)
            )
        )
    in
        if mylist_length(t) <= 1
        then t
        else merge(left, right) where{
            var n = mylist_length(t) / 2;
            var left = split_left(n, t);
            var right = split_right(n, t);
        }
    end
in
    merge_sort(mylist_append(t0, t1))
end
(* ****** ****** *)


implement FV(t0) =
(
case t0 of
|
TMint _ => tvarset_nil()
|
TMvar(x0) => tvarset_sing(x0)
|
TMlam(x0, t1) => tvarset_del1(FV(t1), x0)
|
TMapp(t1, t2) => tvarset_union(FV(t1), FV(t2))
)

(* ****** ****** *)
//
fun
lam_body
(t0: term): term =
case t0 of
| TMlam(_, t1) => lam_body(t1) | _ => t0
//
(* ****** ****** *)

val omega = TMlam("x", TMapp(x, x))

(* ****** ****** *)

val () =
println!("FV(body(K)) = ", FV(lam_body(K))) // x
val () =
println!("FV(body(S)) = ", FV(lam_body(S))) // x, y, z
val () =
println!("FV(body(K')) = ", FV(lam_body(K'))) // y
val () =
println!("FV(SKK) = ", FV(TMapp(TMapp(S, K), K))) // empty

(* ****** ****** *)

val () =
println!("FV(body(omega)) = ", FV(lam_body(omega))) // x

(* ****** ****** *)

(* ****** ****** *)
implement main() = 0
(* ****** ****** *)