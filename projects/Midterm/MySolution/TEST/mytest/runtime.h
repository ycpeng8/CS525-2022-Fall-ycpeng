/*
// A basic runtime for lambda
*/

/* ****** ****** */

#include <stdio.h>
#include <stdlib.h>

/* ****** ****** */

extern
void*
mymalloc(size_t n) {
  void* p0;
  p0 = malloc(n);
  if (p0 != 0) return p0;
  fprintf(stderr, "myalloc failed!!!\n");
  exit(1);
}

/* ****** ****** */

#define TAGint 1
#define TAGstr 2
#define TAGcfp 3 // closure-function-pointer
#define TAGtup 4
#define TAGlst 5

/* ****** ****** */

/*
typedef
lamval0 =
struct{ int tag; }
*/
typedef
struct{ int tag; } lamval0;

/* ****** ****** */

typedef lamval0 *lamval1;

/* ****** ****** */

int
LAMVAL_tag
(lamval1 x){ return x->tag; }

/* ****** ****** */

typedef
struct{
  int tag; int data;
} lamval0_int;
typedef
struct{
  int tag; char *data;
} lamval0_str;

typedef lamval0_int *lamval1_int;
typedef lamval0_str *lamval1_str;

/* ****** ****** */
typedef
struct{
  int tag; 
  lamval1 fst;
  lamval1 snd;
} lamval0_tup;

typedef lamval0_tup *lamval1_tup;
/* ****** ****** */

/* ****** ****** */
typedef
struct{
  int tag; 
  lamval1 ele;
  lamval1 lst;
} lamval0_lst;

typedef lamval0_lst *lamval1_lst;
/* ****** ****** */

/* ****** ****** */
/*
typedef
struct node
{
  lamval1 val;
  struct node *next;
} lamval0_list;

typedef lamval0_list *lamval1_list;
*/
/* ****** ****** */

/* ****** ****** */

extern
lamval1
LAMVAL_int(int i);

extern
lamval1
LAMVAL_str(char *data);

extern
lamval1 
LAMVAL_tup(lamval1 x, lamval1 y);

extern
lamval1
LAMVAL_fst(lamval1 tup0);

extern
lamval1
LAMVAL_snd(lamval1 tup0);
/* ****** ****** */

extern 
lamval1
print_list(lamval1 x);
/* ****** ****** */

extern
lamval1
LAMOPR_add(lamval1 x, lamval1 y);

/* ****** ****** */

extern
lamval1
LAMOPR_sub(lamval1 x, lamval1 y);

/* ****** ****** */

extern
lamval1
LAMOPR_mul(lamval1 x, lamval1 y);

/* ****** ****** */

extern
lamval1
LAMOPR_div(lamval1 x, lamval1 y);

/* ****** ****** */

extern
lamval1
LAMOPR_mod(lamval1 x, lamval1 y);

/* ****** ****** */

extern
lamval1
LAMOPR_ilt(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data < ((lamval1_int)y)->data ? 1 : 0);
}

extern
lamval1
LAMOPR_ile(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data <= ((lamval1_int)y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval1
LAMOPR_igt(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data > ((lamval1_int)y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval1
LAMOPR_ige(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data >= ((lamval1_int)y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval1
LAMOPR_eq(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data == ((lamval1_int)y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval1
LAMOPR_neq(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data != ((lamval1_int)y)->data ? 1 : 0);
}

/* ****** ****** */
extern
lamval1
LAMVAL_int(int i)
{
  lamval1_int p0;
  p0 = mymalloc(sizeof(lamval0_int));
  p0->tag = TAGint; p0->data = i; return (lamval1)p0;
}

extern
lamval1
LAMVAL_str(char *data)
{
  lamval1_str p0;
  p0 = mymalloc(sizeof(lamval0_str));
  p0->tag = TAGstr; p0->data = data; return (lamval1)p0;
}

extern
lamval1 
LAMVAL_tup(lamval1 x, lamval1 y)
{
  lamval1_tup p0;
  p0 = mymalloc(sizeof(lamval0_tup));
  p0->tag = TAGtup;
  p0->fst = x; p0->snd = y;
  return (lamval1)p0;
}

extern
lamval1
LAMVAL_lst(lamval1 x, lamval1 y)
{
  lamval1_lst p0;
  p0 = mymalloc(sizeof(lamval0_lst));
  p0->tag = TAGlst;
  p0->ele = x;
  p0->lst = y;
  return (lamval1)p0;
}

extern
lamval1
LAMVAL_fst(lamval1 tup0)
{
  return ((lamval1_tup)tup0)->fst;
}

extern
lamval1
LAMVAL_snd(lamval1 tup0)
{
  return ((lamval1_tup)tup0)->snd;
}

/* ****** ****** */

extern
lamval1
LAMOPR_add(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data + ((lamval1_int)y)->data);
}

extern
lamval1
LAMOPR_sub(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);ppp
  */
  return
  LAMVAL_int(((lamval1_int)x)->data - ((lamval1_int)y)->data);
}

/* ****** ****** */

extern
lamval1
LAMOPR_mul(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data * ((lamval1_int)y)->data);
}

/* ****** ****** */
extern
lamval1
LAMOPR_div(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data / ((lamval1_int)y)->data);
}

extern
lamval1
LAMOPR_mod(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data % ((lamval1_int)y)->data);
}

extern 
lamval1
LAMOPR_show(lamval1 x)
{
  int tag;
  tag = x->tag;
  switch( tag )
  {
    case TAGstr:
      printf("%s", ((lamval1_str)x)->data); break;
    default: printf("Unrecognized tag = %i", tag);
  }
  return LAMVAL_int(0);
}

extern 
lamval1
LAMOPR_showval(lamval1 x)
{
  int tag;
  tag = x->tag;
  switch( tag )
  {
    case TAGint:
      printf("%i", ((lamval1_int)x)->data); break;
    default: printf("Unrecognized tag = %i", tag);
  }
  return LAMVAL_int(0);
}

// extern 
// lamval1*
// LAMOPR_list_nil()
// {
//   lamval1_list *nil = NULL;
//   nil = (lamval0_list *)mymalloc(sizeof(lamval0_list));
//   nil->val = NULL; nil->next = NULL;
//   return (lamval1*)nil;
// }
/* ****** ****** */

extern
lamval1
LAMOPR_print(lamval1 x)
{
  int tag;
  tag = x->tag;
  switch( tag )
  {
    case TAGcfp:
      printf("<lamval1_cfp>"); break;
    case TAGint:
      printf("%i", ((lamval1_int)x)->data); break;
    case TAGstr:
      printf("%s", ((lamval1_str)x)->data); break;
    case TAGlst:
      printf("[");
      print_list(x); 
      printf("]");
      break;
    default: printf("Unrecognized tag = %i", tag);
  }
  return LAMVAL_int(0);
}

extern 
lamval1
print_list(lamval1 x)
{
  lamval1 ele = ((lamval1_lst)x)->ele;
  lamval1 lst = ((lamval1_lst)x)->lst;

  if (ele != NULL) {
    LAMOPR_print(ele);
    if (((lamval1_lst)lst)->ele != NULL)
    {
      printf(", ");
      print_list(lst);
    }
  }
  return LAMVAL_int(0);
}

extern
lamval1
LAMOPR_lst_nil()
{
  return LAMVAL_lst(NULL, NULL);
}

extern
lamval1
LAMOPR_lst_cons(lamval1 x, lamval1 y)
{
  return LAMVAL_lst(x, y);
}

extern
lamval1
LAMOPR_lst_nilq(lamval1 x)
{
  return LAMVAL_int(((lamval1_lst)x)->lst == NULL);
}

extern
lamval1
LAMOPR_lst_consq(lamval1 x)
{
  return LAMVAL_int(((lamval1_lst)x)->lst != NULL);
}

extern
lamval1
LAMOPR_lst_uncons1(lamval1 x)
{
  return ((lamval1_lst)x)->ele;
}

extern
lamval1
LAMOPR_lst_uncons2(lamval1 x)
{
  return ((lamval1_lst)x)->lst;
}
/* ****** ****** */
