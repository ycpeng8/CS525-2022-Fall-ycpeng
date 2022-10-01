#include "./../assign03.dats"

(* ****** ****** *)
implement
church_numeral_add(
    m: term, n:term
): term=
TMlam("f", TMlam("x", TMapp(TMapp(m, f), TMapp(TMapp(n, f), x)))) where
{
    val x = TMvar("x")
    val f = TMvar("f")
}
(* ****** ****** *)


(* ****** ****** *)
implement 
church_numeral_mul(
    m: term, n: term
): term=
TMlam("f", TMlam("x", TMapp(TMapp(m, TMapp(n, f)), x))) where
{
    val x = TMvar("x")
    val f = TMvar("f")
}
(* ****** ****** *)


(* ****** ****** *)
implement
church_numeral_pow(
    m: term, n: term
): term=
TMlam("f", TMlam("x", TMapp(TMapp(TMapp(n, m), f), x))) where
{
    val x = TMvar("x")
    val f = TMvar("f")
}
(* ****** ****** *)
