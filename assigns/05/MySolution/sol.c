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
isPrime(lamval1 x)
{
    
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
    return 0;
}
