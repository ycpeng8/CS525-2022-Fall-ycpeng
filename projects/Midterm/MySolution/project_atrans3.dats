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
//
(*
HX-2022-10-19:
For A-normal form
*)
//
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

typedef t2cmplst = mylist(t2cmp)


//
extern
fun
t2reg_new(): t2reg
//
(* ****** ****** *)
extern
fun
t2lam_new(): string
(* ****** ****** *)
//
extern
fun
print_t2box(t2box): void
extern
fun
fprint_t2box
(out:FILEref, t1p0:t2box): void
//
overload print with print_t2box
overload fprint with fprint_t2box
//
(* ****** ****** *)
//
extern
fun
print_t2bnd(t2bnd): void
extern
fun
fprint_t2bnd
(out:FILEref, t1p0:t2bnd): void
//
overload print with print_t2bnd
overload fprint with fprint_t2bnd
//
(* ****** ****** *)
//
extern
fun
print_t2ins(t2ins): void
extern
fun
fprint_t2ins
(out:FILEref, t1p0:t2ins): void
//
overload print with print_t2ins
overload fprint with fprint_t2ins
//
(* ****** ****** *)
//
extern
fun
print_t2cmp(t2cmp): void
extern
fun
fprint_t2cmp
(out:FILEref, t1p0:t2cmp): void
//
overload print with print_t2cmp
overload fprint with fprint_t2cmp
//
(* ****** ****** *)
//
typedef
t2env =
mylist(@(t1var, t2cmp))
//
(* ****** ****** *)
(*
HX: for the a-norm-trans
*)
extern
fun
t1erm_atrans0(t1erm): t2cmp
extern
fun
t1dclist_atrans0(t1dclist): t2env
(* ****** ****** *)
extern
fun
t1erm_atrans1
(t1m0: t1erm, env0: t2env): t2cmp
extern
fun
t1dclist_atrans1
(dcls: t1dclist, env0: t2env): t2env
extern
fun
t1ermlst_atrans1
(tms: t1ermlst, xvs: t2env): t2cmplst
extern
fun
t1erm_atrans1_opr
(tm0: t1erm, xvs: t2env): t2cmp
(* ****** ****** *)
//
implement
t1erm_atrans0(t1m0) =
t1erm_atrans1(t1m0, mylist_nil())
//
(* ****** ****** *)
//
implement
t1dclist_atrans0
  (dcls) =
let
val
env0 = mylist_nil()
in//let
t1dclist_atrans1(dcls, env0) end
//
(* ****** ****** *)
//
local
//
val
mycount = ref<int>(0)
//
in//local
//
implement
t2lam_new
((*void*)) =
(
"mylam" +
int2str(n0)) where
{
val n0 = mycount[]
val () = (mycount[] := n0 + 1)}
//
end // end of [local(t2lam_new)]
//
(* ****** ****** *)
//
local
//
val
mycount = ref<int>(0)
//
in//local
//
implement
t2reg_new
((*void*)) = n0 where
{
val n0 = mycount[]
val () = (mycount[] := n0 + 1)}
//
end // end of [local(t2reg_new)]
//
(* ****** ****** *)

implement
fprint_val<t2box> = fprint_t2box
implement
fprint_val<t2bnd> = fprint_t2bnd
implement
fprint_val<t2ins> = fprint_t2ins
implement
fprint_val<t2cmp> = fprint_t2cmp

(* ****** ****** *)

implement
print_t2box(t2x0) =
fprint_t2box(stdout_ref, t2x0)
implement
print_t2bnd(t2b0) =
fprint_t2bnd(stdout_ref, t2b0)
implement
print_t2ins(t2i0) =
fprint_t2ins(stdout_ref, t2i0)
implement
print_t2cmp(t2c0) =
fprint_t2cmp(stdout_ref, t2c0)

(* ****** ****** *)
//
implement
fprint_t2box(out, t2x0) =
(
case+ t2x0 of
//
|
T2Vnil() =>
fprint!(out, "T2Vnil(", ")")
|
T2Vint(int) =>
fprint!(out, "T2Vint(", int, ")")
|
T2Vbtf(btf) =>
fprint!(out, "T2Vbtf(", btf, ")")
|
T2Vstr(str) =>
fprint!(out, "T2Vstr(", str, ")")
//
|
T2Varg(arg) =>
fprint!(out, "T2Varg(", arg, ")")
|
T2Vreg(reg) =>
fprint!(out, "T2Vreg(", reg, ")")
//
|
T2Vlam(tcmp) =>
fprint!(out, "T2Vlam(", tcmp, ")")
//
) (*case+*) // end of [fprint_t2box(out,t2x0)]
//
(* ****** ****** *)
//
implement
fprint_t2bnd(out, tbnd) =
(
case+ tbnd of
|
T2BND(treg, tins) =>
fprint!(out, "T2BND(", treg, ";", tins, ")")
) (*case+*) // end of [fprint_t2box(out,tbnd)]
//
(* ****** ****** *)
//
implement
fprint_t2ins(out, t2i0) =
(
//
case+ t2i0 of
|
T2Ical(t2x1, t2x2) =>
fprint!
(out, "T2Ical(",t2x1,";",t2x2,")")
|
T2Iopr(topr, t2xs) =>
fprint!
(out,"T2Iopr(",topr,";",t2xs,")")
//
|
T2Ifst(t2x1) =>
fprint!(out, "T2Ifst(", t2x1, ")")
|
T2Isnd(t2x1) =>
fprint!(out, "T2Isnd(", t2x1, ")")
|
T2Itup(t2x1, t2x2) =>
fprint!
(out, "T2Itup(",t2x1,";",t2x2,")")
//
|
T2Iif0(t2x1, tbs1, tbs2) =>
fprint!
(out, "T2Iif0(",t2x1,";",tbs1,";",tbs2,")")
//
) (*case+*) // end of [fprint_t2ins(out,t2i0)]
//
(* ****** ****** *)
//
implement
fprint_t2cmp(out, tcmp) =
(
case+ tcmp of
|
T2CMP(bnds, t2x1) =>
fprint!(out, "T2CMP(", bnds, ";", t2x1, ")")
) (*case+*) // end of [fprint_t2box(out,tcmp)]
//
(* ****** ****** *)

fun
t2cmp_val
(t2v0:t2box):t2cmp =
T2CMP(mylist_nil(), t2v0)

(* ****** ****** *)
//
(*
fun
{a:t@ype}
mylist_extend
(xs, x0) = 
(*
HX-2022-11-05:
this is a bug!!!
*)
mylist_append<a>
(xs, mylist_sing(x0))
*)
//
(*
HX-2022-11-11:
This one is already in mylib
*)
overload + with mylist_extend
//

(* ****** ****** *)
extern
fun
t1ermseq_cal
(bds: t2bndlst, ts: t1ermlst, t2x: t2box, env0: t2env):(t2bndlst, t2box)

implement
t1ermseq_cal(bds, ts, t2x, env0) = 
case- ts of
| mylist_nil() => (bds, t2x)
| mylist_cons(tm1, ts1) =>
(
let
val 
T2CMP
(bds1, t2x1) = 
t1erm_atrans1(tm1, env0)
val
bnds = mylist_append(bds, bds1)
in
t1ermseq_cal(bnds, ts1, t2x1, env0)
end
)
(* ****** ****** *)

(* ****** ****** *)
implement
t1erm_atrans1
  (t1m0, env0) =
(
case+ t1m0 of
|
T1Mnil() => 
t2cmp_val(T2Vnil())
//
|
T1Mint(int) =>
t2cmp_val(T2Vint(int))
|
T1Mbtf(btf) =>
t2cmp_val(T2Vbtf(btf))
|
T1Mstr(str) =>
t2cmp_val(T2Vstr(str))
//
|
T1Mtup(t1m1, t1m2) =>
let
//
val
T2CMP
(bds1, t2x1) =
t1erm_atrans1(t1m1, env0)
val
T2CMP
(bds2, t2x2) =
t1erm_atrans1(t1m2, env0)
//
val
treg = t2reg_new()
val
tbnd =
T2BND(treg, T2Itup(t2x1, t2x2))
val
bnds = mylist_append(bds1, bds2)
in//let
  T2CMP(bnds + tbnd, T2Vreg(treg))
end (*let*) // end of [T1Mtup(t1m1,t1m2)]
//
|
T1Mlam
(targ, topt, t1m1) =>
(
t2cmp_val
(T2Vlam(body))) where
{
//
val t2c0 = t2cmp_val(T2Varg(0))
//
val env1 =
mylist_cons(@(targ, t2c0), env0)
val body = t1erm_atrans1(t1m1, env1)
//
} (*where*) // end of [T1Mlam(targ,topt,t1m1)]
//
|
T1Mvar(variable) =>
t2cmp_val(T2Vstr(variable))
//
|
T1Mapp
(tm1, tm2) =>
let
val
T2CMP
(bds1, t2x1) =
t1erm_atrans1(tm1, env0)
val
T2CMP
(bds2, t2x2) =
t1erm_atrans1(tm2, env0)
val
treg = t2reg_new()
val
tbnd =
T2BND(treg, T2Ical(t2x1, t2x2))
val
bnds = mylist_append(bds1, bds2)
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
//
|
T1Mopr _ => t1erm_atrans1_opr(t1m0, env0)
|
T1Mif0(tm1, tm2, tmopt) =>
let
val
T2CMP
(bds1, t2x1) =
t1erm_atrans1(tm1, env0)
val
T2CMP
(bds2, t2x2) =
t1erm_atrans1(tm2, env0)
val
treg = t2reg_new()
in
case- tmopt of
| myoptn_nil() =>
(
let
val
bds3 = mylist_nil()
val
bnds = mylist_append(bds1, bds2)
val
tbnd =
T2BND(treg, T2Iif0(t2x1, bds2, bds3))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
)
| myoptn_cons(tm3) =>
(
let
val
T2CMP
(bds3, t2x3) =
t1erm_atrans1(tm3, env0)
val
bnds = mylist_append(mylist_append(bds1, bds2), bds3)
val
tbnd =
T2BND(treg, T2Iif0(t2x1, bds2, bds3))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
)
end // end of [T1Mif0]
//
|
T1Mfst(tm) =>
let
val 
T2CMP
(bds, t2x) = 
t1erm_atrans1(tm, env0)
val
treg = t2reg_new()
val
tbnd =
T2BND(treg, T2Ifst(t2x))
in
T2CMP(bds + tbnd, T2Vreg(treg))
end
//
|
T1Msnd(tm) =>
let
val 
T2CMP
(bds, t2x) = 
t1erm_atrans1(tm, env0)
val
treg = t2reg_new()
val
tbnd =
T2BND(treg, T2Isnd(t2x))
in
T2CMP(bds + tbnd, T2Vreg(treg))
end
//
| 
T1Mseq(tmlst) =>
(
case- tmlst of
| mylist_nil() => t2cmp_val(T2Vnil())
| mylist_cons(tm1, ts1) =>
(
let
val 
T2CMP
(bds1, t2x1) = 
t1erm_atrans1(tm1, env0)
val
(bnds, t2xfinal) = t1ermseq_cal(bds1, ts1, t2x1, env0)
in
T2CMP(bnds, t2xfinal)
end
)
)
//
|
T1Mfix
(fnm, xnm, tpo_arg, tm1, tpo_res) => 
(t2cmp_val(T2Vlam(bodyf))) where
{
val t2c0x = t2cmp_val(T2Varg(0))
val envx = 
mylist_cons(@(xnm, t2c0x), env0)
// val bodyx = t1erm_atrans1(tm1, envx)
val t2c0f = t2cmp_val(T2Varg(0))
val envf = 
mylist_cons(@(fnm, t2c0f), envx)
val bodyf = t1erm_atrans1(tm1, envf)
}
//
|
T1Mlet(dcls, tm1) =>
let
val
env1 = t1dclist_atrans1(dcls, env0)
in
t1erm_atrans1(tm1, env1)
end
//
|
T1Manno(tm1, tp1) => t1erm_atrans1(tm1, env0)
|
T1Mnone(d1e) => t2cmp_val(T2Vnil())
) (*case+*) // end of [t1erm_atrans1(t1m0,env0)]
  
(* ****** ****** *)

(* ****** ****** *)
implement
t1dclist_atrans1
(dcls, env0) =
case- dcls of
| mylist_nil() => mylist_reverse(env0)
| mylist_cons(dcl1, dcls1) =>
(
let
// t1v: t1var
val-
T1DCLbind(t1v, tm1) = dcl1
val
tc1 = t1erm_atrans1(tm1, env0)
val
env1 = mylist_cons(@(t1v, tc1), env0)
in
t1dclist_atrans1(dcls1, env1)
end
)
(* ****** ****** *)

(* ****** ****** *)
implement
t1ermlst_atrans1(tms, xvs) =
(
case+ tms of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(tm1, tms) =>
mylist_cons
(t1erm_atrans1(tm1, xvs), t1ermlst_atrans1(tms, xvs))
)

implement
t1erm_atrans1_opr
(tm0, xvs) = 
let
val-
T1Mopr(opr, tms) = tm0
val tcs = t1ermlst_atrans1(tms, xvs)
in
(
case- opr of
| "+" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr("+", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "-" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr("-", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "/" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr("/", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "*" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr("*", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "%" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr("%", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "<" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr("<", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| ">" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr(">", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "=" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr("=", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "<=" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr("<=", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| ">=" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr(">=", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "!=" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr("!=", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "show" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
treg = t2reg_new()
val
t2xlst = mylist_sing(t2x1)
val
tbnd =
T2BND(treg, T2Iopr("show", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| "showval" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
treg = t2reg_new()
val
t2xlst = mylist_sing(t2x1)
val
tbnd =
T2BND(treg, T2Iopr("showval", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| "print" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
treg = t2reg_new()
val
t2xlst = mylist_sing(t2x1)
val
tbnd =
T2BND(treg, T2Iopr("print", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| "list_nil" =>
let 
val
treg = t2reg_new()
val
t2xlst = mylist_nil()
val
tbnd =
T2BND(treg, T2Iopr("list_nil", t2xlst))
in
T2CMP(mylist_sing(tbnd), T2Vreg(treg))
end
| "list_cons" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val-
mylist_cons(tc2, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
T2CMP(bds2, t2x2) = tc2
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_pair(t2x1, t2x2)
val
tbnd =
T2BND(treg, T2Iopr("list_cons", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "list_nilq" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
treg = t2reg_new()
val
t2xlst = mylist_sing(t2x1)
val
tbnd =
T2BND(treg, T2Iopr("list_nilq", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| "list_consq" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
treg = t2reg_new()
val
t2xlst = mylist_sing(t2x1)
val
tbnd =
T2BND(treg, T2Iopr("list_consq", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| "list_uncons1" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
treg = t2reg_new()
val
t2xlst = mylist_sing(t2x1)
val
tbnd =
T2BND(treg, T2Iopr("list_uncons1", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| "list_uncons2" =>
let
val-
mylist_cons(tc1, tcs) = tcs
val
T2CMP(bds1, t2x1) = tc1
val
treg = t2reg_new()
val
t2xlst = mylist_sing(t2x1)
val
tbnd =
T2BND(treg, T2Iopr("list_uncons2", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
)
end
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_atrans3.dats] *)
