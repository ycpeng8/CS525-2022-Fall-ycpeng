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
// datatype
// //
// t2cmp =
// T2CMP of
// (t2bndlst, t2box)
// //
// and
// t2box =
// //
// | T2Vnil of ()
// | T2Vint of int
// | T2Vbtf of bool
// | T2Vstr of string
// //
// | T2Varg of (t2arg)
// | T2Vreg of (t2reg)
// //
// | T2Vlam of (t2cmp)
// //
// and t2ins =
// //
// |
// T2Ical of
// (t2box, t2box) // function call
// //
// |
// T2Iopr of
// (t1opr, t2boxlst) // operator call
// //
// |
// T2Ifst of (t2box) // first projection
// |
// T2Isnd of (t2box) // second projection
// |
// T2Itup of (t2box, t2box) // pair formation
// //
// |
// T2Iif0 of (t2box, t2bndlst, t2bndlst)
// //
// and
// t2bnd =
// T2BND of (t2reg, t2ins)
// //
// where
// t2arg = int and
// t2reg = int and
// t2boxlst = mylist(t2box) and
// t2bndlst = mylist(t2bnd) and t2inslst = mylist(t2ins)
// //
// (* ****** ****** *)
// typedef
// t2env =
// mylist(@(t1var, t2cmp))

extern
fun
print_c(t2env): void
extern
fun
temit3
(out:FILEref, env0:t2env): void
//
// overload print with print_c
// overload fprint with temit3
//

(* ****** ****** *)
//
extern
fun
print_box(tb:t2box, env0:t2env): void
extern
fun
temit3_box
(out:FILEref, box:t2box, env0:t2env): void
//
overload print with print_box
overload fprint with temit3_box
//
(* ****** ****** *)
//
extern
fun
print_bnd(t2bnd, env0:t2env): void
extern
fun
temit3_bnd
(out:FILEref, bnd:t2bnd, env0:t2env): void
//
overload print with print_bnd
overload fprint with temit3_bnd
//
(* ****** ****** *)
//
extern
fun
print_ins(ins:t2ins, env0:t2env): void
extern
fun
temit3_ins
(out:FILEref, ins:t2ins, env0:t2env): void
//
overload print with print_ins
overload fprint with temit3_ins
//
(* ****** ****** *)
//
extern
fun
print_cmp(cmp: t2cmp, env0:t2env): void
extern
fun
temit3_cmp
(out:FILEref, cmp:t2cmp, env0:t2env): void
//
overload print with print_cmp
overload fprint with temit3_cmp
//

extern
fun
temit3_opr
(out:FILEref, ins: t2ins, env0:t2env): void

(* ****** ****** *)
//
implement
print_c(env0) =
temit3(stdout_ref, env0)
implement
print_box(box, env0) =
temit3_box(stdout_ref, box, env0)
implement
print_bnd(bnd, env0) =
temit3_bnd(stdout_ref, bnd, env0)
implement
print_ins(ins, env0) =
temit3_ins(stdout_ref, ins, env0)
implement
print_cmp(cmp, env0) =
temit3_cmp(stdout_ref, cmp, env0)
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
(out:FILEref, str:string, env0:t2env) =
fprint!(out, str, env0)

fun
temit3_int
(out:FILEref, i0:int, env0:t2env) =
fprint!(out, i0, env0)

fun
temit3_btf
(out:FILEref, btf:bool, env0:t2env) =
fprint!(out, btf, env0)
(* ****** ****** *)

(* ****** ****** *)
fun
temit3_tbl
(out:FILEref, tbl:t2bndlst, env0:t2env) =
(
case- tbl of
| mylist_cons(bnd, tbl1) => temit3_bnd(out, bnd, env0)
)
(* ****** ****** *)

(* ****** ****** *)
extern
fun
temit3_function(out:FILEref, env0: t2env):void
extern
fun
temit3_main(out:FILEref, env0: t2env):void
(* ****** ****** *)

(* ****** ****** *)
implement
temit3(out, env0) = 
(
    temit3_str(out, "#include \"runtime.h\"", env0);
    temit3_str(out, "\n\n", env0);
    temit3_function(out, env0);
    temit3_str(out, "int main() {\n", env0);
    temit3_main(out, env0);
    temit3_str(out, "}\n", env0);
)
(* ****** ****** *)

(* ****** ****** *)
implement
temit3_main(out, env0) =
(
case- env0 of
| mylist_nil() => temit3_str(out, "", env0)
| mylist_cons(env, env1) =>
let
val-
(tvar1, tc1) = env
val-
T2CMP(tbdlst1, tb1) = tc1
in
case- tb1 of
| T2Vlam _ => temit3_main(out, env1)
| _ => temit3_cmp(out, tc1, env1)
end
)

implement
temit3_function(out, env0) =
(
case- env0 of
| mylist_nil() => temit3_str(out, "", env0)
| mylist_cons(env, env1) =>
let
val-
(tvar1, tc1) = env
val-
T2CMP(tbdlst1, tb1) = tc1
in
case- tb1 of
| T2Vlam _ =>
(
let
val xvs = mylist_cons(@(tvar1, T2CMP(mylist_nil(), T2Varg(1))), mylist_cons(@("x", T2CMP(mylist_nil(), T2Varg(0))), mylist_nil()))
in
temit3_cmp(out, tc1, xvs)
end
)
| _ => temit3_function(out, env1)
end
)
(* ****** ****** *)
extern
fun
t1erm_atrans1_var(out:FILEref, ta: int, env0: t2env): void

implement
t1erm_atrans1_var(out, ta, env0) =
(find(env0)) where
{
fun find(env0: t2env): void =
(
case- env0 of
| mylist_cons(env, env0) =>
(
let
val tvar = env.0
val cmp = env.1
val-
T2CMP(_, targ) = cmp
val-
T2Varg(ta_test) = targ
in
if ta = ta_test
then temit3_str(out, tvar, env0)
else find(env0)
end
)
)
}

(* ****** ****** *)
implement
temit3_box(out, box, env0) =
(
case+ box of
| T2Vnil() => temit3_str(out, "", env0)
| T2Vint(i0) => 
(
    temit3_str(out, "LAMVAL_int(", env0);
    temit3_int(out, i0, env0);
    temit3_str(out, ")", env0);
)
| T2Vbtf(b0) => 
(
    temit3_str(out, "LAMVAL_int(", env0);
    (if b0
    then temit3_int(out, 1, env0)
    else temit3_int(out, 0, env0));
    temit3_str(out, ")", env0);
)
| T2Vstr(s0) => 
(
    temit3_str(out, "LAMVAL_str(", env0);
    temit3_str(out, s0, env0);
    temit3_str(out, ")", env0);
)
| T2Varg(ta) =>
t1erm_atrans1_var(out, ta, env0)
| T2Vreg(tr) =>
(
    temit3_str(out, "tmp", env0);
    temit3_int(out, tr, env0);
)
| T2Vlam(tc) =>
let
val- mylist_cons(env, env1) = env0
val funame = env.0
in
(
    temit3_str(out, "lamval1\n", env0);
    temit3_str(out, funame, env0);
    temit3_str(out, "(lamval1 x)\n", env0);
    temit3_str(out, "{\n", env0);
    temit3_cmp(out, tc, env0);
    temit3_str(out, "}\n", env0);
)
end
)
(* ****** ****** *)

(* ****** ****** *)
implement
temit3_bnd(out, bnd, env0) =
let
val-
T2BND(tr, ins) = bnd
in
case- ins of
| T2Imov(reg2, tb1) =>
let
val-
T2Vreg(tr2) = reg2
in
(
    temit3_str(out, "tmp", env0);
    temit3_int(out, tr2, env0);
    temit3_str(out, " = ", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ";\n", env0);
)
end
| _ =>
(
    temit3_str(out, "tmp", env0);
    temit3_int(out, tr, env0);
    temit3_str(out, " = ", env0);
    temit3_ins(out, ins, env0);
    temit3_str(out, ";\n", env0);
)
end
(* ****** ****** *)

(* ****** ****** *)
implement
temit3_ins(out, ins, env0) =
(
case+ ins of
| T2Imov(t2r, t2b1) =>
(
    temit3_box(out, t2r, env0);
    temit3_str(out, "=", env0);
    temit3_box(out, t2b1, env0);
    temit3_str(out, ";", env0);
)
| T2Ical(t2b1, t2b2) =>
(
    temit3_box(out, t2b1, env0);
    temit3_str(out, "(", env0);
    temit3_box(out, t2b2, env0);
    temit3_str(out, ")", env0);
)
| T2Iopr _ => temit3_opr(out, ins, env0)
| T2Ifst(t2b1) =>
(
    temit3_str(out, "LAMVAL_fst(", env0);
    temit3_box(out, t2b1, env0);
    temit3_str(out, ")", env0);
)
| T2Isnd(t2b1) =>
(
    temit3_str(out, "LAMVAL_snd(", env0);
    temit3_box(out, t2b1, env0);
    temit3_str(out, ")", env0);
)
| T2Itup(t2b1, t2b2) =>
(
    temit3_str(out, "LAMVAL_tup(", env0);
    temit3_box(out, t2b1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, t2b2, env0);
    temit3_str(out, ")", env0);
)
| T2Iif0(t2b1, tbl1, tbl2) =>
(
    temit3_str(out, "if (((lamval1_int)", env0); temit3_box(out, t2b1, env0); temit3_str(out, ")->data) {\n", env0);
    temit3_str(out, "{\n", env0);
    temit3_tbl(out, tbl1, env0);
    temit3_str(out, "} else {\n", env0);
    temit3_tbl(out, tbl2, env0);
    temit3_str(out, "}\n", env0);
)
)
(* ****** ****** *)

fun
create_regs(out:FILEref, tr: int, cal: int, env0: t2env) =
(
case- cal of
| tr =>
(
    temit3_str(out, "tmp", env0);
    temit3_int(out, cal, env0);
    temit3_str(out, ";\n", env0);
)
| _ =>
(
    temit3_str(out, "tmp", env0);
    temit3_int(out, cal, env0);
    temit3_str(out, ", ", env0);
    create_regs(out, tr, cal+1, env0);
)
)
(* ****** ****** *)

(* ****** ****** *)
fun
temit3_bdl(out:FILEref, bdl0: t2bndlst, env0: t2env) = 
(
case- bdl0 of
| mylist_nil() => temit3_str(out, "\n", env0)
| mylist_cons(bd, bdl1) =>
(
    temit3_bnd(out, bd, env0);
    temit3_bdl(out, bdl1, env0);
)
)
(* ****** ****** *)

(* ****** ****** *)
implement
temit3_cmp(out, cmp, env0) =
let
val-
T2CMP(tbdl, tbx) = cmp
in
case- tbx of
| T2Vreg(tr) =>
(
    temit3_str(out, "lamval1 ", env0);
    create_regs(out, tr, 0, env0);
    temit3_bdl(out, tbdl, env0);
)
| T2Vlam _ =>
(
    temit3_box(out, tbx, env0);
)
end
(* ****** ****** *)


(* ****** ****** *)
implement
temit3_opr
(out:FILEref, ins: t2ins, env0) = 
let
val-
T2Iopr(opr, tbs) = ins
in
case- opr of
| "+" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_add(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| "-" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_sub(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| "/" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_div(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| "*" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_mul(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| "%" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_mod(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| "<" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_ilt(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| ">" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_igt(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| "=" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_eq(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| "<=" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_ile(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| ">=" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_ige(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| "!=" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
val-
mylist_cons(tb2, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_neq(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ", ", env0);
    temit3_box(out, tb2, env0);
    temit3_str(out, ")", env0);
)
end
//
| "show" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_show(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ")", env0);
)
end
//
| "print" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_print(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ")", env0);
)
end
//
| "showval" =>
let 
val- 
mylist_cons(tb1, tbs) = tbs
in
(
    temit3_str(out, "LAMOPR_showval(", env0);
    temit3_box(out, tb1, env0);
    temit3_str(out, ")", env0);
)
end
//
end
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_emitter.dats] *)
