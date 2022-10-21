/* ****** ****** */
#include "runtime.h"

/* ****** ****** */
extern
void*
mymalloc(size_t n) 
{
    void* p0;
    p0 = malloc(n);
    if (p0 != 0) return p0;
    fprintf(stderr, "myalloc failed!!!\n");
    exit(1);
}

/* ****** ****** */
extern
void 
LAMVAL_print(lamval1 x)
{
    int tag;
    tag = x -> tag;
    switch (tag)
    {
    case TAGcfp:
        printf("<lamval1_cfp>"); break;
    case TAGint:
        printf("%i", ((lamval1_int)x)->data);break;
    case TAGstr:
        printf("%s", ((lamval1_str)x)->data);break;
    default:
        printf("Unrecognized tag = %i", tag);
    }
}

/* ****** ****** */
/*
fun fibo(x: int) =
  if x >= 2 then fibo(x-2)+fibo(x-1) else x
*/
/* ****** ****** */
extern
lamval1
fibo(lamval1 x)
{
    lamval1 ret0;
    lamval1 tmp1, tmp2, tmp3, tmp4, tmp5;

    tmp1 = LAMOPR_ige(x, LAMVAL_int(2));

    if (((lamval1_int)tmp1)->data)
    {
        tmp2 = LAMOPR_sub(x, LAMVAL_int(2));
        tmp3 = fibo(tmp2);
        tmp4 = LAMOPR_sub(x, LAMVAL_int(1));
        tmp5 = fibo(tmp4);
        ret0 = LAMOPR_add(tmp3, tmp5);
    }
    else
    {
        ret0 = x;
    }

    return ret0;
}

/* ****** ****** */
/*
fun
isPrime
(n: int): bool =
loop( 2 ) where
{
fun
loop(i: int): bool =
if
(i*i > n)
then true
else (if n % i = 0 then false else loop(i+1))
}
*/
/* ****** ****** */
extern
lamval1
loop(lamval1 i, lamval1 n)
{
    lamval1 ret0;
    lamval1 tmp1, tmp2, tmp3, tmp4, tmp5;

    tmp1 = LAMOPR_mul(i, i);
    tmp2 = LAMOPR_igt(tmp1, n);
    tmp3 = LAMOPR_mod(n, i);
    tmp4 = LAMOPR_ieq(tmp3, LAMVAL_int(0));
    if(((lamval1_int)tmp2)->data)
    {
        ret0 = LAMVAL_int(1);
    }
    else if (((lamval1_int)tmp4)->data)
    {
        ret0 = LAMVAL_int(0);
    }
    else
    {
        tmp5 = LAMOPR_add(i, LAMVAL_int(1));
        ret0 = loop(tmp5, n);
    }
    
    return ret0;
}

/* ****** ****** */
extern
lamval1
isPrime(lamval1 n)
{
    lamval1 ret0;

    ret0 = loop(LAMVAL_int(2), n);

    return ret0;
}

/* ****** ****** */
int main()
{
    /*
    fibo() test
    */
    printf("fibo(1) = ");
    LAMVAL_print(fibo(LAMVAL_int(1)));
    printf("\n");
    printf("fibo(4) = ");
    LAMVAL_print(fibo(LAMVAL_int(4)));
    printf("\n");

    /*
    isPrime() test
    */
    printf("isPrime(21) = ");
    LAMVAL_print(isPrime(LAMVAL_int(21)));
    printf("\n");
    printf("isPrime(23) = ");
    LAMVAL_print(isPrime(LAMVAL_int(23)));
    printf("\n");

    return 0;
}
