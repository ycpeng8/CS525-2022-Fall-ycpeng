(* ****** ****** *)
#staload "./project.sats"
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
#staload
"./../../../mylib/mylib.dats"
(* ****** ****** *)

(* ****** ****** *)
// Finally...
(* ****** ****** *)

(* ****** ****** *)
// datatype
// t3val =
// | T3Vnil of T2Vnil
// | T3Vint of T2Vint
// | T3Vbtf of T2Vbtf
// | T3Vstr of T2Vstr
// //
// | T3Varg of T2Varg
// | T3Vreg of T2Vreg
// //
// | T3Vlam of T2Vlam
// //
// and
// t3ins =
// | T3Imov of
// | T3Ical of
// | T3Iif0 of 
(* ****** ****** *)

(* ****** ****** *)
datatype
//
t2cmp =
T2CMP of
(t2bndlst, t2box)
//
and
t2box =
//
| T2Vnil of ()
| T2Vint of int
| T2Vbtf of bool
| T2Vstr of string
//
| T2Varg of (t2arg)
| T2Vreg of (t2reg)
//
| T2Vlam of (t2cmp)
//
and t2ins =
//
|
T2Ical of
(t2box, t2box) // function call
//
|
T2Iopr of
(t1opr, t2boxlst) // operator call
//
|
T2Ifst of (t2box) // first projection
|
T2Isnd of (t2box) // second projection
|
T2Itup of (t2box, t2box) // pair formation
//
|
T2Iif0 of (t2box, t2bndlst, t2bndlst)
//
and
t2bnd =
T2BND of (t2reg, t2ins)
//
where
t2arg = int and
t2reg = int and
t2boxlst = mylist(t2box) and
t2bndlst = mylist(t2bnd) and t2inslst = mylist(t2ins)
//
(* ****** ****** *)
typedef
t2env =
mylist(@(t1var, t2cmp))

extern
fun
print_c(t2env): void
extern
fun
temit3
(out:FILEref, env0:t2env): void
//
overload print with print_c
overload fprint with temit3
//

(* ****** ****** *)
//
extern
fun
print_box(t2box): void
extern
fun
temit3_box
(out:FILEref, box:t2box): void
//
overload print with print_box
overload fprint with temit3_box
//
(* ****** ****** *)
//
extern
fun
print_bnd(t2bnd): void
extern
fun
temit3_bnd
(out:FILEref, bnd:t2bnd): void
//
overload print with print_bnd
overload fprint with temit3_bnd
//
(* ****** ****** *)
//
extern
fun
print_ins(t2ins): void
extern
fun
temit3_ins
(out:FILEref, ins:t2ins): void
//
overload print with print_ins
overload fprint with temit3_ins
//
(* ****** ****** *)
//
extern
fun
print_cmp(t2cmp): void
extern
fun
temit3_cmp
(out:FILEref, cmp:t2cmp): void
//
overload print with print_cmp
overload fprint with temit3_cmp
//

(* ****** ****** *)
//
implement
print_c(env0) =
temit3(stdout_ref, env0)
implement
print_box(box) =
temit3_box(stdout_ref, box)
implement
print_bnd(bnd) =
temit3_bnd(stdout_ref, bnd)
implement
print_ins(ins) =
temit3_ins(stdout_ref, ins)
implement
print_cmp(cmp) =
temit3_cmp(stdout_ref, cmp)
//
(* ****** ****** *)

// implement
// fprint_val<t2box> = temit3_box
// implement
// fprint_val<t2bnd> = temit3_bnd
// implement
// fprint_val<t2ins> = temit3_ins
// implement
// fprint_val<t2cmp> = temit3_cmp

(* ****** ****** *)

fun
temit3_str
(out:FILEref, str:string) =
fprint!(out, str)

fun
temit3_int
(out:FILEref, i0:int) =
fprint!(out, i0)

fun
temit3_btf
(out:FILEref, btf:bool) =
fprint!(out, btf)
(* ****** ****** *)

(* ****** ****** *)
implement
temit3(out, env0) = 
(
case- env0 of
| mylist_nil() => temit3_str(out, "nil")
| mylist_cons(env, env1) => temit3_str(out, "cons")
)

(* ****** ****** *)

(* ****** ****** *)
implement
temit3_box(out, box) =
case- box of
| T2Vnil => temit3_str(out, "")
| T2Vint(i0) => temit3_int(out, i0)
| T2Vbtf(b0) => temit3_btf(out, b0)
| T2Vstr(s0) => temit3_str(out, s0)
(* ****** ****** *)

(* ****** ****** *)
implement
temit3_bnd(out, bnd) =
(
)
(* ****** ****** *)

(* ****** ****** *)
implement
temit3_ins(out, ins) =
let
val () =
println!
("ins")
in
end
(* ****** ****** *)

(* ****** ****** *)
implement
temit3_cmp(out, cmp) =
let
val () =
println!
("cmp")
in
end
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_emitter.dats] *)
