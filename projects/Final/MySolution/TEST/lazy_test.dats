fun
generate(pair: (int, int) , sum: int): lazy(strm(int, int)) =
$lazy
(
let
    val p1 = fst(pair)
    val p2 = snd(pair)
in
    if p1 + 1 <= sum
    then strm_cons(pair, generate((p1+1, sum-p1-1), sum))
    else strm_cons(pair, generate((0, sum+1), sum+1))
end
)

// test pairs generator
val theNat2s = generate((0, 0), 0)
val ns = $eval(theNat2s)
val p = strm_uncons1(ns)
val theNat2s = strm_uncons2(ns)
val p0 = fst(p)
val p1 = snd(p)
val _1_ = 
(print("p = ("); print(p0); print(", "); print(p1); print(")"); print("\n"))