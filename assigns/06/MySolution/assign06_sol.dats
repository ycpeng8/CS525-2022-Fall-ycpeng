#include "./../assign06.dats"

implement main0() = ()

(* ****** ****** *)

(*
Problem 1:
I generate all the natural number pairs 
whose sum equal 0, then 1,2,3,... in ascending order.
In this way, we can traverse every value of either of two arguments, avoiding
infinitely traversing (0, 0), (0, 1), (0, 2), ...
For instance, in my test, the order of generated pair should be:
p = (0, 0)          sum: 0
p = (0, 1)          sum: 1
p = (1, 0)          sum: 1
p = (0, 2)          sum: 2
p = (1, 1)          sum: 2
p = (2, 0)          sum: 2
p = (0, 3)          sum: 3
p = (1, 2)          sum: 3
p = (2, 1)          sum: 3
p = (3, 0)          sum: 3
p = (0, 4)          sum: 4
...
*)
fun
generate(pair: int2, sum: int): stream(int2) =
$delay
(
let
    val-(p1, p2) = pair
in
    if p1 + 1 <= sum
    then stream_cons(pair, generate((p1+1, sum-p1-1), sum))
    else stream_cons(pair, generate((0, sum+1), sum+1))
end
)

// test pairs generator
val theNat2s = generate((0, 0), 0)
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")
val-
stream_cons(p, theNat2s) = !theNat2s
val () = println!("p = (", p.0, ", ", p.1, ")")

(* ****** ****** *)

(* 
Problem 2:
The procedure I designed is:
    for N from 0:
        while True:
            Generate a pair (i, j)
            if i in the next pair <= N:         // That is, i+1 <= N
                if f0(i, j) == N:
                    output this N and keep the stream at this point
                else:
                    continue
            else:
                if f0(i, j) == N:
                    output this N and keep the stream at this point 
                    break
                else:
                    break
        N++
Test: I use f0(i, j) = i*i + j*j to test my function
The expected outputs should be 0,1,1,2,4,4,5,5,8,9,9,10,10
*)
fun 
f0(i: int, j: int): int = i*i + j*j

fun
stream_fenum2
(f0: (int, int) -> int): stream(int) =
$delay(!(exam(generate((0, 0), 0), 0)))
where
{
fun
exam(ps: stream(int2), N: int): stream(int) =
$delay
(
let
    val-stream_cons(p, ps) = !ps
    val-(p1, p2) = p
    val f0_val = f0(p1, p2)
in
    if p1 + 1 <= N
    then 
    (
        if f0_val = N
        then stream_cons(N, exam(ps, N))
        else !(exam(ps, N))
    )
    else 
    (
        if f0_val = N
        then stream_cons(N, exam(generate((0, 0), 0), N+1))
        else !(exam(generate((0, 0), 0), N+1))
    )
end
)
}

// test
val () = println!("*************************")
val test_fenum2 = stream_fenum2(f0)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)
val-
stream_cons(x, test_fenum2) = !test_fenum2
val () = println!("x = ", x)

(* ****** ****** *)

(*
Problem 3
*)
fun
lam_test(i: int, j: int): int = (i + 2) * (j + 2)

val
theCompounds = stream_fenum2(lam_test)

fun
from(n:int): stream(int) =
$delay(stream_cons(n, from(n+1)))

fun
sieve(xs: stream(int), cs: stream(int)): stream(int) = 
$delay
(
let
    val-stream_cons(x1, xs) = !xs
    val-stream_cons(c1, cs) = !cs
in
    if x1 < c1
    then stream_cons(x1, sieve(xs, $delay(stream_cons(c1, cs))))
    else !(sieve(xs, removeDup(cs, c1)))
end
)
where
{
// remove the duplicated number
// For instance, if cs2 = (2,2,2,4,5), c = 2, then return (4,5)
fun 
removeDup(cs2: stream(int), c: int): stream(int) =
$delay
(
let
    val-stream_cons(c2, cs2) = !cs2
in
    if c2 <= c
    then !(removeDup(cs2, c))
    else stream_cons(c2, cs2)
end
)
}

val
thePrimes = sieve(from(0), theCompounds) 

// test
val () = println!("*************************")
val-
stream_cons(x, thePrimes) = !thePrimes
val () = println!("x = ", x)
val-
stream_cons(x, thePrimes) = !thePrimes
val () = println!("x = ", x)
val-
stream_cons(x, thePrimes) = !thePrimes
val () = println!("x = ", x)
val-
stream_cons(x, thePrimes) = !thePrimes
val () = println!("x = ", x)
val-
stream_cons(x, thePrimes) = !thePrimes
val () = println!("x = ", x)
val-
stream_cons(x, thePrimes) = !thePrimes
val () = println!("x = ", x)
val-
stream_cons(x, thePrimes) = !thePrimes
val () = println!("x = ", x)
val-
stream_cons(x, thePrimes) = !thePrimes
val () = println!("x = ", x)
(* ****** ****** *)
