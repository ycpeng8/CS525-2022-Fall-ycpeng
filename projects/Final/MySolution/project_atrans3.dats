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
print_t2cmp(cmp: t2cmp): void
extern
fun
fprint_t2cmp
(out:FILEref, t1p0:t2cmp): void
//
overload print with print_t2cmp
overload fprint with fprint_t2cmp
//

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
(dcls: t1dclist, dcls_atrans: t2env, env0: t2env): (t2env, t2env)
extern
fun
t1dclist_atrans1_in_atrans
(dcls: t1dclist, env0: t2env): t2env
extern
fun
t1ermlst_atrans1
(tms: t1ermlst, xvs: t2env): t2cmplst
extern
fun
t1erm_atrans1_opr
(tm0: t1erm, xvs: t2env): t2cmp
extern
fun
t1erm_atrans1_var
(t1m0: t1erm, xvs: t2env): t2cmp
extern
fun
t1dclist_atrans1_let
(dcls: t1dclist, bdnl: t2bndlst, env0: t2env): (t2bndlst, t2env)
extern
fun
reg_if_if(tregr: t2reg, tbnd: t2bnd): t2bnd
extern
fun
reg_if_if_tbs(treg: t2reg, bndl: t2bndlst): t2bndlst
(* ****** ****** *)

(* ****** ****** *)
extern
fun
find_args(bds: t2bndlst, tbx: t2box): (t2bndlst, t2boxlst)
(* ****** ****** *)

(* ****** ****** *)
extern
fun
find_cfp_env(lam_bds2: t2bndlst, env0: t2env, cfp_env: t2env): t2env
(* ****** ****** *)


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
val
dcls_atrans = mylist_nil()
val
(dcls_atrans, env0) = t1dclist_atrans1(dcls, dcls_atrans, env0)
in//let
dcls_atrans 
end
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
|
T2Vvar(tv) =>
fprint!(out, "T2Vvar(", tv, ")")
//
|
T2Vfix(fnm) =>
fprint!(out, "T2Vfix(", fnm, ")")
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
T2Imov(t2x1) =>
fprint!
(out, "T2Imov(",t2x1,")")
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
| T2Ilet(dcs1) =>
fprint!
(out, "T2Ilet(", dcs1, ")")
//
// | T2Icfp(t2x1, dcs1) =>
// fprint!
// (out, "T2Icfp(", t2x1, ";", dcs1, ")")
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

extern
fun
t2cmp_val
(t2v0:t2box):t2cmp

implement
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
t1erm_atrans1_var
(t1m0, xvs) =
let
val-
T1Mvar(x) = t1m0
in
find(xvs) where
{
fun find(xvs: t2env): t2cmp=
(
case- xvs of
| mylist_cons(xv1, xvs) =>
(if x = xv1.0 then 
let
val-T2CMP(bnds, t2x1) = xv1.1
in
case- t2x1 of
// | T2Vlam(_) => t2cmp_val(T2Vvar(xv1.0))
| _ => xv1.1 
end
else find(xvs))
)
}
end
(* ****** ****** *)

(* ****** ****** *)
implement
reg_if_if(tregr, tbnd) =
let
val-T2BND(treg, tins) = tbnd
in
case- tins of
| T2Iif0(t2x1, tbs1, tbs2) => 
let
val tbs1 = reg_if_if_tbs(tregr, tbs1)
val tbs2 = reg_if_if_tbs(tregr, tbs2)
in
T2BND(tregr, T2Iif0(t2x1, tbs1, tbs2))
end
| _ => T2BND(tregr, tins)
end

implement
reg_if_if_tbs(treg, bndl) =
let
val bndl_reverse = mylist_reverse(bndl)
val-mylist_cons(bnd, bndl_reverse) = bndl_reverse
val bnd = reg_if_if(treg, bnd)
val bndl_reverse = mylist_cons(bnd, bndl_reverse)
val bndl = mylist_reverse(bndl_reverse)
in
bndl
end
(* ****** ****** *)

implement
find_cfp_env(lam_bds2, env0, cfp_env) =
case- lam_bds2 of
| mylist_nil() => cfp_env
| mylist_cons(lam_bnd2, lam_bds2) =>
let
val-T2BND(treg, tins) = lam_bnd2
in
case- tins of
| T2Iopr(_, t2bxlst) =>
let
val-mylist_cons(t2x1, t2bxlst) = t2bxlst
val-mylist_cons(t2x2, t2bxlst) = t2bxlst
in
  case- t2x1 of
  | T2Vvar(x1) => 
    let
    val tcmp1 = t1erm_atrans1_var(T1Mvar(x1), env0)
    val cfp_env = mylist_cons(@(x1, tcmp1), cfp_env)
    in
      case- t2x2 of
      | T2Vvar(x2) => 
        let
        val tcmp2 = t1erm_atrans1_var(T1Mvar(x2), env0)
        val cfp_env = mylist_cons(@(x2, tcmp2), cfp_env)
        in
          find_cfp_env(lam_bds2, env0, cfp_env)
        end
      | _ => find_cfp_env(lam_bds2, env0, cfp_env)
    end
  | _ =>
  (
    case- t2x2 of
    | T2Vvar(x2) => 
      let
      val tcmp2 = t1erm_atrans1_var(T1Mvar(x2), env0)
      val cfp_env = mylist_cons(@(x2, tcmp2), cfp_env)
      in
        find_cfp_env(lam_bds2, env0, cfp_env)
      end
    | _ => find_cfp_env(lam_bds2, env0, cfp_env)
  )
end
| T2Ical(tbx1, tbx2) =>
(
  case- tbx1 of
  | T2Vvar(x1) => 
    let
    val tcmp1 = t1erm_atrans1_var(T1Mvar(x1), env0)
    val cfp_env = mylist_cons(@(x1, tcmp1), cfp_env)
    in
      case- tbx2 of
      | T2Vvar(x2) => 
        let
        val tcmp2 = t1erm_atrans1_var(T1Mvar(x2), env0)
        val cfp_env = mylist_cons(@(x2, tcmp2), cfp_env)
        in
          find_cfp_env(lam_bds2, env0, cfp_env)
        end
      | _ => find_cfp_env(lam_bds2, env0, cfp_env)
    end
  | _ =>
  (
    case- tbx2 of
    | T2Vvar(x2) => 
      let
      val tcmp2 = t1erm_atrans1_var(T1Mvar(x2), env0)
      val cfp_env = mylist_cons(@(x2, tcmp2), cfp_env)
      in
        find_cfp_env(lam_bds2, env0, cfp_env)
      end
    | _ => find_cfp_env(lam_bds2, env0, cfp_env)
  )
)
end


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
in
case- t1m2 of
// | T1Mlam(targ, topt, tmlam) =>
// let
// val-mylist_cons(bd2, bds2) = bds2
// val-T2BND(tg, ti) = bd2
// val-T2Icfp(tlam, _) = ti
// val-T2Vlam(body) = tlam
// val-T2CMP(lam_bds2, tbx) = body

// val cfp_env = find_cfp_env(lam_bds2, env0, mylist_nil()) // find cfp env

// val treg_cfp = t2reg_new()
// val 
// tbnd_cfp = T2BND(treg_cfp, T2Icfp(T2Vlam(body), cfp_env))
// val bnds = bds1 + tbnd_cfp
// val
// treg = t2reg_new()
// val
// tbnd =
// T2BND(treg, T2Itup(t2x1, T2Vreg(treg_cfp)))
// in
// T2CMP(bnds + tbnd, T2Vreg(treg))
// end
| _ =>
let
val
treg = t2reg_new()
val
tbnd =
T2BND(treg, T2Itup(t2x1, t2x2))
val
bnds = mylist_append(bds1, bds2)
in//let
  T2CMP(bnds + tbnd, T2Vreg(treg))
end 

end (*let*) // end of [T1Mtup(t1m1,t1m2)]
//
|
T1Mlam
(targ, topt, t1m1) =>
let
val t2c0 = t2cmp_val(T2Varg(0))
val env1 =
mylist_cons(@(targ, t2c0), env0)
val body = t1erm_atrans1(t1m1, env1)
val 
treg = t2reg_new()
in
// T2CMP(mylist_sing(T2BND(treg, T2Icfp(T2Vlam(body), mylist_nil()))), T2Vreg(treg));
T2CMP(mylist_nil(), T2Vlam(body))
end (*let*) // end of [T1Mlam(targ,topt,t1m1)]

// (
// t2cmp_val
// (T2Vlam(body))) where
// {
// //
// val t2c0 = t2cmp_val(T2Varg(0))
// //
// val env1 =
// mylist_cons(@(targ, t2c0), env0)
// val body = t1erm_atrans1(t1m1, env1)
// //
// } (*where*) // end of [T1Mlam(targ,topt,t1m1)]
//
|
// T1Mvar(tv) =>
// t2cmp_val(T2Vvar(tv))
T1Mvar(tv) =>
t1erm_atrans1_var(t1m0, env0)
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
//
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
| myoptn_nil() => // tmopt option
(
case- bds2 of
| mylist_nil() => // tm2 option
let
val 
bds2lst = mylist_cons(T2BND(treg, T2Imov(t2x2)), mylist_nil())
val 
tbnd = T2BND(treg, T2Iif0(t2x1, bds2lst, mylist_nil()))
val tbnd = reg_if_if(treg, tbnd)
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| mylist_cons(bd2, bds21) => // tm2 option
let
// replace last register of bd2
val bds2_reversed = mylist_reverse(bds2)
val-mylist_cons(bdr, bds2_rest) = bds2_reversed
val-T2BND(tregr, tinsr) = bdr
val bdr = T2BND(treg, tinsr)   
val bds2_reversed = mylist_cons(bdr, bds2_rest)
val bds2lst = mylist_reverse(bds2_reversed)
val 
tbnd = T2BND(treg, T2Iif0(t2x1, bds2lst, mylist_nil()))
val tbnd = reg_if_if(treg, tbnd)
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
)
| myoptn_cons(tm3) => // tmopt option
let
val
T2CMP
(bds3, t2x3) =
t1erm_atrans1(tm3, env0)
in
case- bds2 of
| mylist_nil() => // tm2 option
    let
    val 
    bds2lst = mylist_cons(T2BND(treg, T2Imov(t2x2)), mylist_nil())
    in
    case- bds3 of
    | mylist_nil() => // tm3 option
    let
    val
    bds3lst = mylist_cons(T2BND(treg, T2Imov(t2x3)), mylist_nil())
    val
    tbnd = T2BND(treg, T2Iif0(t2x1, bds2lst, bds3lst))
    val tbnd = reg_if_if(treg, tbnd)
    in
    T2CMP(bds1 + tbnd, T2Vreg(treg))
    end
    | mylist_cons(bd3, bds31) => // tm3 option
    let
    // replace last register of bd3
    val bds3_reversed = mylist_reverse(bds3)
    val-mylist_cons(bdr, bds3_rest) = bds3_reversed
    val-T2BND(tregr, tinsr) = bdr
    val bdr = T2BND(treg, tinsr)   
    val bds3_reversed = mylist_cons(bdr, bds3_rest)
    val bds3lst = mylist_reverse(bds3_reversed)
    val
    tbnd = T2BND(treg, T2Iif0(t2x1, bds2lst, bds3lst))
    val tbnd = reg_if_if(treg, tbnd)
    in
    T2CMP(bds1 + tbnd, T2Vreg(treg))
    end
    end
| mylist_cons(bd2, bds21) => // tm2 option
    let
    // replace last register of bd2
    val bds2_reversed = mylist_reverse(bds2)
    val-mylist_cons(bdr, bds2_rest) = bds2_reversed
    val-T2BND(tregr, tinsr) = bdr
    val bdr = T2BND(treg, tinsr)   
    val bds2_reversed = mylist_cons(bdr, bds2_rest)
    val bds2lst = mylist_reverse(bds2_reversed)
    in
    case- bds3 of
    | mylist_nil() => // tm3 option
    let
    val
    bds3lst = mylist_cons(T2BND(treg, T2Imov(t2x3)), mylist_nil())
    val
    tbnd = T2BND(treg, T2Iif0(t2x1, bds2lst, bds3lst))
    val tbnd = reg_if_if(treg, tbnd)
    in
    T2CMP(bds1 + tbnd, T2Vreg(treg))
    end
    | mylist_cons(bd3, bds31) => // tm3 option
    let
    // replace last register of bd3
    val bds3_reversed = mylist_reverse(bds3)
    val-mylist_cons(bdr, bds3_rest) = bds3_reversed
    val-T2BND(tregr, tinsr) = bdr
    val bdr = T2BND(treg, tinsr)   
    val bds3_reversed = mylist_cons(bdr, bds3_rest)
    val bds3lst = mylist_reverse(bds3_reversed)
    val
    tbnd = T2BND(treg, T2Iif0(t2x1, bds2lst, bds3lst))
    val tbnd = reg_if_if(treg, tbnd)
    in
    T2CMP(bds1 + tbnd, T2Vreg(treg))
    end
    end
end // end of myoptn_cons(tm3)
end // end of T1Mif0(tm1, tm2, tmopt)
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
let
val t2c0 = t2cmp_val(T2Varg(0))
val t2cf = t2cmp_val(T2Vfix(fnm))
val env1 =
mylist_cons(@(fnm, t2cf), mylist_cons(@(xnm, t2c0), env0))
val body = t1erm_atrans1(tm1, env1)
val 
treg = t2reg_new()
in
// T2CMP(mylist_sing(T2BND(treg, T2Icfp(T2Vlam(body), mylist_nil()))), T2Vreg(treg));
T2CMP(mylist_nil(), T2Vlam(body))
end (*let*) // end of [T1Mfix(targ,topt,t1m1)]

// (
// t2cmp_val
// (T2Vlam(body))) where
// {
// //
// val t2c0 = t2cmp_val(T2Varg(0))
// val t2cf = t2cmp_val(T2Vfix(fnm))
// //
// val env1 =
// mylist_cons(@(fnm, t2cf), mylist_cons(@(xnm, t2c0), env0))
// val body = t1erm_atrans1(tm1, env1)
// //
// } (*where*) // end of [T1Mfix(targ,topt,t1m1)]

//
|
T1Mlet(dcls, tm1) =>
let
val
dcls_atrans = mylist_nil()
val
(dcls1, env1) = t1dclist_atrans1(dcls, dcls_atrans, env0) // local vars 
val
treg = t2reg_new()
val
tbnd =
T2BND(treg, T2Ilet(dcls1))
// val
// env1 = t1dclist_atrans1(dcls, env0)
// val-T2CMP(bndl1, t2x1) = t1erm_atrans1(tm1, env1)
val-T2CMP(bndl1, t2x1) = t1erm_atrans1(tm1, env1)
val
bndl = mylist_cons(tbnd, bndl1)
in
T2CMP(bndl, t2x1)
end
//
|
T1Mlazy(tm1) =>
t1erm_atrans1(tm1, env0)
//
|
T1Manno(tm1, tp1) => t1erm_atrans1(tm1, env0)
|
T1Mnone(d1e) => t2cmp_val(T2Vnil())
) (*case+*) // end of [t1erm_atrans1(t1m0,env0)]
(* ****** ****** *)


(* ****** ****** *)
// implement
// t1dclist_atrans1_in_atrans
// (dcls, env0) =
// case- dcls of
// | mylist_nil() => mylist_reverse(env0)
// | mylist_cons(dcl1, dcls1) =>
// let
// // t1v: t1var
// val-
// T1DCLbind(t1v, tm1) = dcl1
// val
// tc1 = t1erm_atrans1(tm1, env0)
// val-T2CMP(bds1, t2x1) = tc1
// in
// case- t2x1 of
// | T2Vlam(_) =>
// let
// val
// env1 = mylist_cons(@(t1v, t2cmp_val(T2Vfix(t1v))), env0)
// in
// t1dclist_atrans1(dcls1, env1)
// end
// | _ =>
// let
// val
// env1 = mylist_cons(@(t1v, tc1), env0)
// in
// t1dclist_atrans1(dcls1, env1)
// end
// end


implement
t1dclist_atrans1
(dcls, dcls_atrans, env0) =
case- dcls of
| mylist_nil() => (mylist_reverse(dcls_atrans), env0)
| mylist_cons(dcl1, dcls1) =>
(
let
// t1v: t1var
val-
T1DCLbind(t1v, tm1) = dcl1
val
tc1 = t1erm_atrans1(tm1, env0)
val
dcls_atrans = mylist_cons(@(t1v, tc1), dcls_atrans)
val-T2CMP(bds1, t2x1) = tc1
val
env1 = mylist_cons(@(t1v, t2cmp_val(T2Vvar(t1v))), env0)
val
env2 = mylist_cons(@(t1v, t2cmp_val(T2Vfix(t1v))), env0)
in
case- t2x1 of
| T2Vlam(_) => t1dclist_atrans1(dcls1, dcls_atrans, env2)
| _ => t1dclist_atrans1(dcls1, dcls_atrans, env1)
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
| "strm_nil" =>
let 
val
treg = t2reg_new()
val
t2xlst = mylist_nil()
val
tbnd =
T2BND(treg, T2Iopr("strm_nil", t2xlst))
in
T2CMP(mylist_sing(tbnd), T2Vreg(treg))
end
| "strm_cons" =>
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
(bds2, t2xs) = find_args(bds2, t2x2)
val
bnds = mylist_append(bds1, bds2)
val
treg = t2reg_new()
val
t2xlst = mylist_cons(t2x1, t2xs)
val
tbnd =
T2BND(treg, T2Iopr("strm_cons", t2xlst))
in
T2CMP(bnds + tbnd, T2Vreg(treg))
end
| "strm_nilq" =>
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
T2BND(treg, T2Iopr("strm_nilq", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| "strm_consq" =>
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
T2BND(treg, T2Iopr("strm_consq", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| "strm_uncons1" =>
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
T2BND(treg, T2Iopr("strm_uncons1", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| "strm_uncons2" =>
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
T2BND(treg, T2Iopr("strm_uncons2", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
| "$eval" =>
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
T2BND(treg, T2Iopr("$eval", t2xlst))
in
T2CMP(bds1 + tbnd, T2Vreg(treg))
end
)
end
(* ****** ****** *)


implement
find_args(bds, tbx) =
let
val-
mylist_cons(bd, bds) = mylist_reverse(bds)
val-
T2BND(treg, ins) = bd
in
case- ins of
| T2Ical(t2b1, t2b2) => (mylist_reverse(bds), mylist_pair(t2b1, t2b2))
| _ => (bds, mylist_sing(tbx))
end
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_atrans3.dats] *)
