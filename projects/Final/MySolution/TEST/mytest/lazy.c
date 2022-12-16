#include "runtime.h"

lamval1
generate(lamval1 x)
{
    lamval1 ret0;
    lamval1 tmp0, tmp1, tmp2;

    tmp0 = LAMOPR_add(x, LAMVAL_int(1));
    // tmp1 = generate(tmp0);
    // tmp1 = generate;

    tmp2 = strm_cons(x, generate, tmp0);
    // ret0 = LAMVAL_lazy(tmp2);
    ret0 = tmp2;

    return ret0;
}

int main()
{

    lamval1 tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8;

    tmp0 = generate(LAMVAL_int(0));
    tmp1 = eval(tmp0);
    tmp2 = strm_uncons1(tmp1);
    tmp3 = strm_uncons2(tmp1);
    tmp4 = LAMOPR_print(tmp2);
    tmp5 = eval(tmp3);
    tmp6 = strm_uncons1(tmp5);
    tmp7 = strm_uncons2(tmp5);
    tmp8 = LAMOPR_print(tmp6);

    return 0;
}