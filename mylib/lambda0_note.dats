datatype intlst = 
| intlst_nil of ()
| intlst_cons of (int, intlst)

#define nil intlst_nil
#define :: intlst_cons
#define cons intlst_cons



val l0 = nil()
val l1 = cons(1, l0)
val l2 = cons(2, l1)

val () = println!("show")

implement main() = 0   // dummy

