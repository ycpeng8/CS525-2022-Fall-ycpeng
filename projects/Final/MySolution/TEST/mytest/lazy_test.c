#include "runtime.h"


lamval1
generate(lamval1 x)
{

lamval1 tmp3, tmp1, tmp0, tmp2, tmp5, tmp6, tmp7, tmp8, tmp9, tmp10, tmp11, tmp15, tmp16, tmp17, tmp18, tmp14;

tmp0 = LAMVAL_fst(x);

lamval1 pair = tmp0;

tmp1 = LAMVAL_snd(x);

lamval1 sum = tmp1;

tmp2 = LAMVAL_fst(pair);

lamval1 p1 = tmp2;

tmp3 = LAMVAL_snd(pair);

lamval1 p2 = tmp3;

tmp5 = LAMOPR_add(p1, LAMVAL_int(1));
tmp6 = LAMOPR_ile(tmp5, sum);
if (((lamval1_int)tmp6)->data)
{
tmp7 = LAMOPR_add(p1, LAMVAL_int(1));
tmp8 = LAMOPR_sub(sum, p1);
tmp9 = LAMOPR_sub(tmp8, LAMVAL_int(1));
tmp10 = LAMVAL_tup(tmp7, tmp9);
tmp11 = LAMVAL_tup(tmp10, sum);
tmp14 = strm_cons(pair, generate, tmp11);
}
else
{
tmp15 = LAMOPR_add(sum, LAMVAL_int(1));
tmp16 = LAMVAL_tup(LAMVAL_int(0), tmp15);
tmp17 = LAMOPR_add(sum, LAMVAL_int(1));
tmp18 = LAMVAL_tup(tmp16, tmp17);
tmp14 = strm_cons(pair, generate, tmp18);
}

return tmp14;
}



int main() 
{

lamval1 tmp39, tmp37, tmp35, tmp28, tmp26, tmp24, tmp21, tmp22, tmp23, tmp25, tmp27, tmp29, tmp30, tmp31, tmp32, tmp33, tmp34, tmp36, tmp38, tmp40, tmp41, tmp42, tmp43, tmp44, tmp45;

tmp21 = LAMVAL_tup(LAMVAL_int(0), LAMVAL_int(0));
tmp22 = LAMVAL_tup(tmp21, LAMVAL_int(0));
tmp23 = generate(tmp22);

lamval1 theNat2s = tmp23;

tmp24 = eval(theNat2s);

lamval1 ns = tmp24;

tmp25 = strm_uncons1(ns);

lamval1 p = tmp25;

tmp26 = strm_uncons2(ns);

lamval1 theNat2s1 = tmp26;

tmp27 = LAMVAL_fst(p);

lamval1 p0 = tmp27;

tmp28 = LAMVAL_snd(p);

lamval1 p1 = tmp28;

tmp29 = LAMOPR_print(LAMVAL_str("p = ("));
tmp30 = LAMOPR_print(p0);
tmp31 = LAMOPR_print(LAMVAL_str(", "));
tmp32 = LAMOPR_print(p1);
tmp33 = LAMOPR_print(LAMVAL_str(")"));
tmp34 = LAMOPR_print(LAMVAL_str("\n"));

lamval1 _1_ = tmp34;

tmp35 = eval(theNat2s1);

lamval1 ns2 = tmp35;

tmp36 = strm_uncons1(ns2);

lamval1 ps = tmp36;

tmp37 = strm_uncons2(ns2);

lamval1 theNat2s2 = tmp37;

tmp38 = LAMVAL_fst(ps);

lamval1 p3 = tmp38;

tmp39 = LAMVAL_snd(ps);

lamval1 p4 = tmp39;

tmp40 = LAMOPR_print(LAMVAL_str("p1 = ("));
tmp41 = LAMOPR_print(p3);
tmp42 = LAMOPR_print(LAMVAL_str(", "));
tmp43 = LAMOPR_print(p4);
tmp44 = LAMOPR_print(LAMVAL_str(")"));
tmp45 = LAMOPR_print(LAMVAL_str("\n"));

lamval1 _2_ = tmp45;

return 0;

}