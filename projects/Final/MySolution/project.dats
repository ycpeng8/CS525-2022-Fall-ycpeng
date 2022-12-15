//
%{^
//
extern
void
libxatsopt_dynloadall();
//
%} (* %{^ *)
val () =
$extfcall
(void, "libxatsopt_dynloadall")
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
"./../../../mylib/mylib.dats"
//
(* ****** ****** *)
//
#include
"./../../HATS/libxatsopt.hats"
//
(* ****** ****** *)

#staload "./project.sats"
#staload "./project_t1ype.dats"
#staload "./project_t1erm.dats"
#staload "./project_interp1.dats"
#staload "./project_tcheck2.dats"
#staload "./project_atrans3.dats"
// #staload "./project_emitter.dats"

(* ****** ****** *)

#dynload "./project_trans.dats"
#dynload "./project_t1ype.dats"
#dynload "./project_t1erm.dats"
#dynload "./project_t1val.dats"
#dynload "./project_interp1.dats"
#dynload "./project_tcheck2.dats"
#dynload "./project_atrans3.dats"
// #dynload "./project_emitter.dats"

(* ****** ****** *)
//
extern
fun
the_fixity_load
(
XATSHOME: string
) : void = "ext#libxatsopt_the_fixity_load"
//
(* ****** ****** *)

local
//
static
fun
process_stdin(): void
static
fun
process_fpath(fp0: fpath_t): void
static
fun
process_given(given: string): void
//
(* ****** ****** *)

implement
process_stdin() =
(
  process_fpath(fp0)) where
{
  val
  fp0 = $FP0.the_filpath_stdin
} (*where*) // end of [process_stdin]

(* ****** ****** *)

implement
process_fpath(fp0) =
let
//
val
stadyn = 1 // dynamic
//
in//let
//
if
(
stadyn >= 0
)
then
{
val
d0cs =
let
val dpar =
parse_from_filpath_toplevel
  (stadyn, fp0)
in//let
case+
dpar.parsed() of
| Some(d0cs) => d0cs
| None((*void*)) => list_nil()
end : d0eclist // end-of-val
//
val () =
synread_d0eclist(d0cs)
//
val
d1cs = trans01_declist(d0cs)
(*
val () =
println!
("process_fpath: d1cs = ", d1cs)
*)
val () =
tread01_d1eclist(d1cs)
//
val
t1ds = trans1m_d1eclist(d1cs)
val () =
println!
("process_fpath: t1ds = ", t1ds)

val
t1cs = t1dclist_interp0(t1ds)

val t1p = t1dclist_oftype0(t1ds)
val () = 
println!
("Type Checking Pass!!!")

val t2atrans = t1dclist_atrans0(t1ds)
val () = 
println!
("atrans: t2atrans = ", t2atrans)

// val () =
// println!
// ("C Code:\n")
// val () = temit3(t2atrans)

// val () =
// println!
// ("process_fpath: t1v = ", t1v)
// val () =
// println!
// ("process_fpath: t1cs = ", t1cs)

} (* end of [then] *)
else
{
// ~(stadyn >= 0) // not for loading code
} (* end of [else] *)
//
end (*let*) // end of [process_fpath(fp0)]

(* ****** ****** *)

implement
process_given
  (arg0) = let
//
val fp0 =
let
val given = arg0
val fname = arg0
in//let
fpath_make(given, fname)
end (*let*)//end-of-val(fp0)
//
(*
val () =
println!
("process_given: arg0 = ", arg0)
*)
//
in
  process_fpath(fp0)
end (*let*) // end of [process_given(arg0)]

in(*in-of-local*)

implement
project_main0
(argc, argv) =
let
//
val
XATSHOME =
"./../../Xanadu" // hard-code
(* 
$GLO.the_XATSHOME_get() // more flexible
*)
//
val
((*void*)) =
the_fixity_load(XATSHOME)
//
in
if
(argc = 1)
then process_stdin() else process_given(argv[1])
end // project_main0

end // end of [local]

(* ****** ****** *)

implement
main0(argc, argv) =
(
//
if
(argc >= 2)
then project_main0(argc, argv)
else prerrln! ("Hello from CS525(Midterm)!")
// end of [if]
) (* end of [main] *)

(* ****** ****** *)
// implement main0() = ()

// val t1ds = T1DCLbind(fact;T1Mfix(f;x;some(T1Pbas(int));T1Mif0(T1Mopr(>;T1Mvar(x); T1Mint(0));T1Mopr(*;T1Mvar(x); T1Mapp(T1Mvar(f);T1Mopr(-;T1Mvar(x); T1Mint(1))));some(T1Mint(1));some(T1Pbas(int)))); T1DCLbind(_;T1Mseq(T1Mopr(print;T1Mstr(fact(10) = )); T1Mopr(print;T1Mapp(T1Mvar(fact);T1Mint(10))); T1Mopr(print;T1Mstr(
// ))))


// val tm1 = 
// T1Mapp(T1Mlam("x", myoptn_cons(T1Pint), x), T1Mint(1))
// where
// {
//   val x = T1Mvar("x")
// }
(* ****** ****** *)

// val tm1 = 
// T1Mapp(T1Mlam("x", myoptn_cons(T1Pint), x), T1Mint(1))
// where
// {
//   val x = T1Mvar("x")
// }

// val () =
// println!("tc1: ", t1erm_atrans0(tm1))

// val
// mysum2 =
// T1Mfix("f", "m", myoptn_cons(T1Pint),
// T1Mif0(T1Mgt(m, T1Mint(0)), T1Madd(m, T1Mapp(f, T1Msub(m, T1Mint(1)))), myoptn_cons(T1Mint(0))), myoptn_cons(T1Pint)) where
// {
//   val f = T1Mvar("f")
//   val m = T1Mvar("m")
// }

// (* ****** ****** *)

// val () =
// println!("mysum2: ", t1erm_oftype0(mysum2))
// val () =
// println!("mysum2(100) = ", t1erm_interp0(T1Mapp(mysum2, T1Mint(100))))

(* ****** ****** *)
// val () = println!("tv1: ", t1erm_interp0(tm1))
// val () = println!("\n")
// val () = println!("tp1: ", t1erm_oftype0(tm1))



// val tm1 = 
// T1Mseq(mylist_cons(T1Mprint(T1Mstr("fst")), 
// mylist_cons(T1Mprint(T1Mstr("snd")), mylist_nil())))

// val tm1 = 
// T1Mseq(mylist_cons(T1Mapp(x, T1Mint(1)), mylist_cons(T1DCLbind("x", T1Mprint(T1Madd(x, T1Mint(2)))), mylist_nil())))
// where
// {
//   val x = T1Mvar("x")
// }

// val tm1 =
// mylist_cons(T1DCLbind("x", T1Mint(1)), mylist_nil())

// val env0 = t1dclist_interp0(tm1)
// val env1 = t1dclist_oftype0(tm1)


// val tm1 = 
// T1Mopr("list_cons", mylist_cons(T1Mstr("fst"), mylist_nil()))
// val tm1 = 
// list_cons(T1Mstr("fst"), list_nil())

// val () = println!("tv1: ", t1erm_interp0(tm1))

(* end of [CS525-2022-Fall/Midterm_project.dats] *)
