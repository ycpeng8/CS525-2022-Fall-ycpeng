#include "runtime.h"
#include <string.h>

/* ****** ****** */



/* ****** ****** */

lamval1
cfp1(lamval1 x, lamval1 env[])
{
    lamval1 ret0;
    lamval1 arg = LAMVAL_fst(x);
    lamval1 env = LAMVAL_snd(x);

    ret0 = arg;

    return ret0;
}

lamval1
cfp2(lamval1 x, lamval1 env[])
{
    lamval1 ret0;
    lamval1 tmp0;

    lamval1 n = env[1];
    lamval1 (*k)(lamval1 a) = (lamval1 (*)(lamval1))env[0];
    
    tmp0 = LAMOPR_mul(n, x);
    ret0 = k(tmp0);

    return ret0;
}

lamval1
kfact(lamval1 x, lamval1 env[])
{
    lamval1 ret0;
    lamval1 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6;

    lamval1 n = LAMVAL_fst(x);

    lamval1 cfp = LAMVAL_snd(x);
    lamval1 (*k)(lamval1 a) = ((lamval1_cfp)cfp)->cfp_func;
    // lamval1 env* = ((lamval1_cfp)cfp)->env;
    // lamval1[0] env = ((lamval1_cfp1)k)->env;
    lamval1 print = LAMOPR_print(LAMVAL_str("n: "));
    lamval1 print2 = LAMOPR_print(n);

    tmp0 = LAMOPR_igt(n, LAMVAL_int(0));
    if (((lamval1_int)tmp0)->data)
    {
        tmp1 = LAMOPR_sub(n, LAMVAL_int(1));
        lamval1 env1[2] = {(lamval1)k, n};
        tmp2 = LAMVAL_cfp((lamval1)cfp2, (lamval1)env1);
        tmp3 = LAMVAL_tup(tmp1, tmp2);
        lamval1 env2[0] = {};
        ret0 = kfact(tmp3, env2);
    }
    else
    {
        ret0 = k(LAMVAL_int(1), ((lamval1_cfp)cfp)->env);
    }

    return ret0;
}

lamval1
fact(lamval1 x, lamval1 env[])
{
    lamval1 ret0;
    lamval1 tmp0, tmp1;

    lamval1 tmp3[0] = {};
    tmp0 = LAMVAL_cfp((lamval1)cfp1, (lamval1)tmp3);
    tmp1 = LAMVAL_tup(x, tmp0);
    lamval1 tmp4[0] = {};
    ret0 = kfact(tmp1, tmp4);

    return ret0;
}


int main()
{
    lamval1 tmp0, tmp1, tmp2, tmp3;

    tmp0 = LAMOPR_print(LAMVAL_str("fact(10) = "));
    lamval1 tmp4[0] = {};
    tmp1 = fact(LAMVAL_int(10), tmp4);
    tmp2 = LAMOPR_print(tmp1);
    tmp3 = LAMOPR_print(LAMVAL_str("\n"));

    return 0;
}