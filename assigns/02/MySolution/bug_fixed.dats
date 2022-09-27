(* ****** ****** *)
(*
Due: Monday, the 26th of September
*)
(* ****** ****** *)
(*
HX-2022-09-21:
This assignment asks you to implement
certain lambda-terms.
*)
(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)
// #staload "./../../../mylib/mylib.dats"
#include "./../assign02.dats"
// #include
// "./../../..\
// /lectures/lecture-09-26/lambda0.dats"

(* ****** ****** *)
//
// 05 points
// extern
// fun Y(): term // the Y fixed-point operator
//


implement
Y(): term=
TMlam("f", TMapp(wf, wf))
where
{
// val wf = TMlam("x", TMapp(f, TMlam("v", TMapp(x, TMapp(x, v)))))
// val wf = TMlam("x", TMapp(f, TMlam("v", TMapp(TMapp(x, x), v))))
val f = TMvar("f")
val x = TMvar("x")
val v = TMvar("v")
val wf = TMlam("x", TMapp(f, TMapp(x, x)))
}
(* ****** ****** *)
//
// 05 points
(*
fact(x) = if x > 0 then x * fact(x-1) else 1
*)
implement
fact(): term=
TMapp(Y(), F)
where
{
    val f = TMvar("f")
    val x = TMvar("x")
    val v = TMvar("v")
    val zero = TMint(0)
    val one = TMint(1)
    val two = TMint(2)
    val F = TMlam("f", TMlam("x", TMif0(TMgt(x, zero), TMmul(x, TMapp(f, TMsub(x, one))), one)))
}

(* ****** ****** *)
//
// 05 points
(*
fibo(x) = if x >= 2 then fibo(x-1)+fibo(x-2) else x
*)
implement
fibo(): term=
TMapp(Y(), F)
where
{
    val f = TMvar("f")
    val x = TMvar("x")
    val v = TMvar("v")
    val zero = TMint(0)
    val one = TMint(1)
    val two = TMint(2)
    val F = TMlam("f", TMlam("x", TMif0(TMgte(x, zero), TMadd(TMapp(f, TMsub(x, one)), TMapp(f, TMsub(x, two))), x)))
}

(* ****** ****** *)



// val () = println!("Y = ", Y())
// val () =
// println!
// ("interp(fact(10)) = ", term_interp(TMapp(fact(),TMint(10))))
// val () =
// println!
// ("interp(fibo(10)) = ", term_interp(TMapp(fibo(),TMint(10))))

(* ****** ****** *)

(* ****** ****** *)
// implement main() = 0
(* ****** ****** *)

(* end of [CS525-2022-Fall/assigns/assign02.dats] *)
