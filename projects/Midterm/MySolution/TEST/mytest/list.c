#include "runtime.h"


lamval1
square(lamval1 x)
{

lamval1 tmp9, tmp5, tmp8, tmp11, tmp12, tmp7;

tmp5 = LAMOPR_lst_nilq(x);
if (((lamval1_int)tmp5)->data)
{
tmp7 = LAMOPR_lst_nil();
}
else
{
tmp8 = LAMOPR_lst_uncons1(x);

lamval1 x1 = tmp8;

tmp9 = LAMOPR_lst_uncons2(x);

lamval1 xs = tmp9;

tmp11 = LAMOPR_mul(x1, x1);
tmp12 = square(xs);
tmp7 = LAMOPR_lst_cons(tmp11, tmp12);
}

return tmp7;
}

lamval1
length(lamval1 x)
{

lamval1 tmp0, tmp2, tmp3, tmp1;

tmp0 = LAMOPR_lst_nilq(x);
if (((lamval1_int)tmp0)->data)
{
tmp1 = LAMVAL_int(0);
}
else
{
tmp2 = LAMOPR_lst_uncons2(x);
tmp3 = length(tmp2);
tmp1 = LAMOPR_add(LAMVAL_int(1), tmp3);
}

return tmp1;
}



int main() 
{

lamval1 tmp28, tmp27, tmp26, tmp24, tmp23, tmp22, tmp21, tmp17, tmp15, tmp14, tmp16, tmp18, tmp19, tmp20, tmp25, tmp29, tmp30, tmp31, tmp32;

tmp14 = LAMOPR_lst_nil();

lamval1 xs = tmp14;

tmp15 = LAMOPR_lst_cons(LAMVAL_int(3), xs);

lamval1 xs1 = tmp15;

tmp16 = LAMOPR_lst_cons(LAMVAL_int(2), xs1);

lamval1 xs2 = tmp16;

tmp17 = LAMOPR_lst_cons(LAMVAL_int(1), xs2);

lamval1 xs3 = tmp17;

tmp18 = LAMOPR_print(LAMVAL_str("xs = "));
tmp19 = LAMOPR_print(xs3);
tmp20 = LAMOPR_print(LAMVAL_str("\n"));

lamval1 _1_ = tmp20;

tmp21 = LAMOPR_print(LAMVAL_str("|xs| = "));
tmp22 = length(xs3);
tmp23 = LAMOPR_print(tmp22);
tmp24 = LAMOPR_print(LAMVAL_str("\n"));

lamval1 _2_ = tmp24;

tmp25 = square(xs3);

lamval1 ys = tmp25;

tmp26 = LAMOPR_print(LAMVAL_str("ys = "));
tmp27 = LAMOPR_print(ys);
tmp28 = LAMOPR_print(LAMVAL_str("\n"));

lamval1 _3_ = tmp28;

tmp29 = LAMOPR_print(LAMVAL_str("|ys| = "));
tmp30 = length(ys);
tmp31 = LAMOPR_print(tmp30);
tmp32 = LAMOPR_print(LAMVAL_str("\n"));

lamval1 _4_ = tmp32;

return 0;

}