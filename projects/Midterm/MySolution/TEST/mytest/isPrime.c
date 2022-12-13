#include "runtime.h"


lamval1
loop(lamval1 x)
{

lamval1 tmp1, tmp0, tmp3, tmp4, tmp6, tmp7, tmp9, tmp10, tmp5;

tmp0 = LAMVAL_fst(x);
lamval1 n = tmp0;
tmp1 = LAMVAL_snd(x);
lamval1 i = tmp1;
tmp3 = LAMOPR_mul(i, i);
tmp4 = LAMOPR_igt(tmp3, n);
if (((lamval1_int)tmp4)->data)
{
tmp5 = LAMVAL_int(1);
}
else
{
tmp6 = LAMOPR_mod(n, i);
tmp7 = LAMOPR_eq(tmp6, LAMVAL_int(0));
if (((lamval1_int)tmp7)->data)
{
tmp5 = LAMVAL_int(0);
}
else
{
tmp9 = LAMOPR_add(i, LAMVAL_int(1));
tmp10 = LAMVAL_tup(n, tmp9);
tmp5 = loop(tmp10);
}
}

return tmp5;
}

lamval1
isPrime(lamval1 x)
{

lamval1 tmp13, tmp14;

tmp13 = LAMVAL_tup(x, LAMVAL_int(2));
tmp14 = loop(tmp13);

return tmp14;
}



int main() 
{

lamval1 tmp22, tmp21, tmp20, tmp19, tmp15, tmp16, tmp17, tmp18, tmp23, tmp24, tmp25, tmp26;

tmp15 = LAMOPR_print(LAMVAL_str("isPrime(11) = "));
tmp16 = isPrime(LAMVAL_int(11));
tmp17 = LAMOPR_print(tmp16);
tmp18 = LAMOPR_print(LAMVAL_str("\n"));
tmp19 = LAMOPR_print(LAMVAL_str("isPrime(101) = "));
tmp20 = isPrime(LAMVAL_int(101));
tmp21 = LAMOPR_print(tmp20);
tmp22 = LAMOPR_print(LAMVAL_str("\n"));
tmp23 = LAMOPR_print(LAMVAL_str("isPrime(1001) = "));
tmp24 = isPrime(LAMVAL_int(1001));
tmp25 = LAMOPR_print(tmp24);
tmp26 = LAMOPR_print(LAMVAL_str("\n"));

lamval1 lst = LAMOPR_lst_nil();
lamval1 lst1 = LAMOPR_lst_cons(LAMVAL_int(1), lst);
lamval1 lst2 = LAMOPR_lst_cons(LAMVAL_int(2), lst1);

LAMOPR_print(LAMOPR_lst_uncons1(lst2));
LAMOPR_print(LAMOPR_lst_uncons2(lst2));


return 0;

}