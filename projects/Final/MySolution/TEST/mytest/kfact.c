#include "runtime.h"
#include <string.h>

/* ****** ****** */
typedef
struct{
  int tag;
  lamval1 (*cfp_func)(lamval1 arg);
  lamval1 env[0];
} lamval0_cfp1;

typedef lamval0_cfp1 *lamval1_cfp1;

lamval1 
LAMVAL_cfp1(lamval1 (*cfp_func)(lamval1 arg), lamval1 env[0])
{
  lamval1_cfp1 tmp0;
  tmp0 = (lamval1_cfp1)malloc(sizeof(lamval0_cfp1));
  tmp0->tag = TAGcfp;
  tmp0->cfp_func = cfp_func;
  memcpy(tmp0->env, env, 0);
  return (lamval1)tmp0;
}

typedef
struct{
  int tag;
  lamval1 (*cfp_func)(lamval1 arg);
  lamval1 env[2];
} lamval0_cfp2;

typedef lamval0_cfp2 *lamval1_cfp2;

lamval1 
LAMVAL_cfp2(lamval1 (*cfp_func)(lamval1 arg), lamval1 env[2])
{
  lamval1_cfp2 tmp0;
  tmp0 = (lamval1_cfp2)malloc(sizeof(lamval0_cfp2));
  tmp0->tag = TAGcfp;
  tmp0->cfp_func = cfp_func;
  memcpy(tmp0->env, env, 2);
  return (lamval1)tmp0;
}

/* ****** ****** */

lamval1
cfp1(lamval1 x)
{
    lamval1 ret0;

    lamval1 arg = LAMVAL_fst(x);
    lamval1 env[0];
    memcpy(env[0], *LAMVAL_snd(x), 0);

    ret0 = arg;

    return ret0;
}

lamval1
cfp2(lamval1 x)
{
    lamval1 ret0;

    lamval1 tmp0;

    lamval1 arg = LAMVAL_fst(x);
    lamval1 env[2] = LAMVAL_snd(x);

    lamval1 (*cfp_func)(lamval1 a) = env[0];
    lamval1 n = env[1];
    
    tmp0 = LAMOPR_mul(n, arg);
    ret0 = cfp_func(tmp0);

    return ret0;
}

lamval1
kfact(lamval1 x)
{
    lamval1 ret0;
    lamval1 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6;

    lamval1 n = LAMVAL_fst(x);

    lamval1 cfp = LAMVAL_snd(x);
    lamval1 (*k)(lamval1 a) = ((lamval1_cfp1)cfp)->cfp_func;
    // lamval1[0] env = ((lamval1_cfp1)k)->env;

    tmp0 = LAMOPR_igt(n, LAMVAL_int(0));
    if (((lamval1_int)tmp0)->data)
    {
        tmp1 = LAMOPR_sub(n, LAMVAL_int(1));
        tmp5 = LAMVAL_tup("k", k);
        tmp6 = LAMVAL_tup("n", n);
        tmp2 = LAMVAL_cfp1(cfp2, lamval1[2]{tmp4, tmp6});
        tmp3 = LAMVAL_tup(tmp1, tmp2);
        ret0 = kfact(tmp3);
    }
    else
    {
        tmp4 = LAMVAL_tup(LAMVAL_int(1), env);
        ret0 = k(tmp4, );
    }

    return ret0;
}

lamval1
fact(lamval1 x)
{
    lamval1 ret0;
    lamval1 tmp0, tmp1;

    tmp0 = LAMVAL_cfp1(cfp1, (lamval1[0]){});
    tmp1 = LAMVAL_tup(x, tmp0);
    ret0 = kfact(tmp1);

    return ret0;
}


int main()
{
    lamval1 tmp0, tmp1, tmp2, tmp3;

    tmp0 = LAMOPR_print(LAMVAL_str("fact(10) = "));
    tmp1 = fact(LAMVAL_int(10));
    tmp2 = LAMOPR_print(tmp1);
    tmp3 = LAMOPR_print(LAMVAL_str("\n"));

    return 0;
}
