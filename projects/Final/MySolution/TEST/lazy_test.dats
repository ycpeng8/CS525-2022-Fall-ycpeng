fun
generate(arg: ((int, int), int)): lazy(strm(int, int)) =
$lazy
(
let
    val pair = fst(arg)
    val sum = snd(arg)
    val p1 = fst(pair)
    val p2 = snd(pair)
in
    if p1 + 1 <= sum
    then strm_cons(pair, generate(((p1+1, sum-p1-1), sum)))
    else strm_cons(pair, generate(((0, sum+1), sum+1)))
end
)

// test pairs generator
val theNat2s = generate((0, 0), 0)
val ns = $eval(theNat2s)
val p = strm_uncons1(ns)
val theNat2s1 = strm_uncons2(ns)
val p0 = fst(p)
val p1 = snd(p)
val _1_ = 
(print("p = ("); print(p0); print(", "); print(p1); print(")"); print("\n"))
val ns2 = $eval(theNat2s1)
val ps = strm_uncons1(ns2)
val theNat2s2 = strm_uncons2(ns2)
val p3 = fst(ps)
val p4 = snd(ps)
val _2_ =
(print("p1 = ("); print(p3); print(", "); print(p4); print(")"); print("\n"))