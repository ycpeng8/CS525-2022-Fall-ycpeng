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
extern
fun
t1erm_interp1
( t1m0
: t1erm, env0: t1env): t1val
extern
fun
t1ermlst_interp1
( t1ms
: t1ermlst, env0: t1env): t1valist
(* ****** ****** *)
//
implement
t1erm_interp0(t1m0) =
t1erm_interp1(t1m0, mylist_nil())
//
(* ****** ****** *)


(* ****** ****** *)
// Yanchong: My work begins here...
(* ****** ****** *)
typedef t1valist = mylist(t1val)

// t1erm variable interpretor
extern
fun
t1erm_interp1_var
(t1ms: t1erm, env0: t1env): t1val
extern
fun
t1erm_interp1_opr
(tm0: t1erm, xvs: t1env): t1val
extern
fun
t1dclist_interp1(dcls: t1dclist, env0: t1env): t1env

//
implement
t1dclist_interp0
  (dcls) =
let
val
env0 = mylist_nil()
in t1dclist_interp1(dcls, env0) end
//
(* ****** ****** *)

implement
t1ermlst_interp1(tms, xvs) =
(
case+ tms of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(tm1, tms) =>
mylist_cons
(t1erm_interp1(tm1, xvs), t1ermlst_interp1(tms, xvs))
)

fun 
t1v_print(xv: t1val) =
(
case- xv of
  | T1Vint(integer) => print(integer)
  | T1Vbtf(boolean) => print(boolean)
  | T1Vstr(string) => print(string)
)

fun
interp_print_lst(tvlst: mylist(t1val)) =
(
case- tvlst of
| mylist_nil() => print(")")
| mylist_cons(xv, xs) =>
{
val () = t1v_print(xv)
val () = print(", ")
val () = interp_print_lst(xs)
}
)

implement
t1erm_interp1_opr
  (tm0, xvs) =
let
//
val-
T1Mopr(opr, tms) = tm0
val tvs = t1ermlst_interp1(tms, xvs)
//
in//let
(
case- opr of
//
| "+" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vint(i1+i2)
end
| "-" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vint(i1-i2)
end
| "*" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vint(i1*i2)
end
| "/" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vint(i1/i2)
end
| "%" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vint(i1%i2)
end
//
| "<" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 < i2)
end
| ">" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 > i2)
end
| "=" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 = i2)
end
| "<=" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 <= i2)
end
| ">=" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 >= i2)
end
| "!=" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vint(i1) = tv1 and T1Vint(i2) = tv2 in T1Vbtf(i1 != i2)
end
| "show" =>
let
val-
mylist_cons(tv1, tvs) = tvs
in
  case- tv1 of
  | T1Vstr(str) => let val () = print(str) in T1Vnil() end
end
//
| "showval" =>
let
val-
mylist_cons(tv1, tvs) = tvs 
in print(tv1); T1Vnil() end
//
| "print" =>
let
val-
mylist_cons(tv1, tvs) = tvs
in
(
  case- tv1 of
  | T1Vint(integer) => let val () = print(integer) in T1Vnil() end
  | T1Vbtf(boolean) => let val () = print(boolean) in T1Vnil() end
  | T1Vstr(string) => let val () = print(string) in T1Vnil() end
  | T1Vcons(tag, tvlst) => 
    let
    val () = 
    if tag = 0
    then 
    {
    val () = print("list_nil()") 
    }
    else 
    {
    val () = print("(")
    val () = interp_print_lst(tvlst)
    }
    in
    T1Vnil()
    end
)
end
| "list_nil" => 
T1Vcons(0, mylist_nil())
| "list_cons" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val-
T1Vcons(_, lst) = tv2
in
T1Vcons(1, mylist_cons(tv1, lst))
end
| "list_nilq" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
T1Vcons(flag, _) = tv1
in
if flag = 0 then T1Vbtf(true) else T1Vbtf(false)
end
| "list_consq" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
T1Vcons(flag, _) = tv1
in
if flag = 0 then T1Vbtf(false) else T1Vbtf(true)
end
| "list_uncons1" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
T1Vcons(_, lst) = tv1
val-
tv1_head = mylist_head(lst)
in
tv1_head
end
| "list_uncons2" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
T1Vcons(_, lst) = tv1
val-
tv1_tail = mylist_tail(lst)
in
case- tv1_tail of
| mylist_nil() => T1Vcons(0, tv1_tail)
| mylist_cons(_, _) => T1Vcons(1, tv1_tail)
end
| "strm_nil" =>
T1Vcons(0, mylist_nil())
| "strm_cons" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
mylist_cons(tv2, tvs) = tvs
val 
lst = mylist_sing(tv2)
// val-
// T1Vcons(_, lst) = tv2
// val-
// T1Vlazy(strm) = tv2
// val-
// T1Vcons(_, lst) = strm
in
T1Vcons(1, mylist_cons(tv1, lst))
end
| "strm_nilq" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
T1Vcons(flag, _) = tv1
in
if flag = 0 then T1Vbtf(true) else T1Vbtf(false)
end
| "strm_consq" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
T1Vcons(flag, _) = tv1
in
if flag = 0 then T1Vbtf(false) else T1Vbtf(true)
end
| "strm_uncons1" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
T1Vcons(_, lst) = tv1
val-
tv1_head = mylist_head(lst)
in
tv1_head
end
| "strm_uncons2" =>
let
val-
mylist_cons(tv1, tvs) = tvs
val-
T1Vcons(_, lst) = tv1
val-
tv1_tail = mylist_tail(lst)
in
case- tv1_tail of
// | mylist_nil() => T1Vcons(0, tv1_tail)
// | mylist_cons(_, _) => T1Vcons(1, tv1_tail)
| mylist_nil() => T1Vcons(0, tv1_tail)
| mylist_cons(x, _) => x
end
| "$eval" =>
// let
// val-
// mylist_cons(tv1, tvs) = tvs
// val-
// T1Vlazy(strm) = tv1
// in
// strm
// end
let
val-
mylist_cons(tv1, tvs) = tvs
val-
T1Vlazy(tm1, env0) = tv1
val-
x = t1erm_interp1(tm1, env0)
// val () = 
// (
//   case- x of
//   | T1Vstrm(_, _) => print("strm")
//   | T1Vlazy(_, _) => print("lazy")
// )
in
x
end
)
end (*let*) // end of [t1erm_interp_opr(tm0, xvs)]

implement
t1erm_interp1_var
(t1ms, env0) =
let
val-T1Mvar(x) = t1ms 
in
find(env0) where
{
fun find(env0: t1env): t1val =
(
case- env0 of
| mylist_cons(xv1, env0) =>
  (if x = xv1.0 then xv1.1 else find(env0))
)
}
end
(* ****** ****** *)

(* ****** ****** *)
// Implementation of t1erm interpretor
implement
t1erm_interp1(t1ms, env0) =
(
case t1ms of
//
| T1Mnil() => T1Vnil()
//
| T1Mint(i0) => T1Vint(i0)
| T1Mbtf(b0) => T1Vbtf(b0)
| T1Mstr(s0) => T1Vstr(s0)
//
|
T1Mvar _ =>
t1erm_interp1_var(t1ms, env0)
//
|
T1Mlam
(xnm, tpo1, tm1) => 
(
case- tpo1 of
| myoptn_nil() => T1Vlam(t1ms, env0)
| myoptn_cons(tp1) => T1Vlam(T1Mlam(xnm, myoptn_nil(), tm1), env0)
)
//
|
T1Mapp(tm1, tm2) =>
let
val
tv1 = t1erm_interp1(tm1, env0)
val
tv2 = t1erm_interp1(tm2, env0)
in//let
case- tv1 of
|
T1Vlam(T1Mlam(xnm, myoptn_nil(), tbd), env0) =>
t1erm_interp1
(tbd, mylist_cons(@(xnm, tv2), env0))
|
T1Vfix(T1Mfix(fnm, xnm, myoptn_nil(), tbd, myoptn_nil()), env0) =>
t1erm_interp1
(tbd, mylist_cons(@(fnm, tv1), mylist_cons(@(xnm, tv2), env0)))
end // let // end of [T1Mapp]
//
|
T1Mopr _ => t1erm_interp1_opr(t1ms, env0)
//
|
T1Mif0(tm1, tm2, tmopt) =>
let
val tv1 = t1erm_interp1(tm1, env0)
in//let
case- tv1 of
|
T1Vbtf(b1) =>
if b1 
then t1erm_interp1(tm2, env0)
else 
(
case- tmopt of
| myoptn_nil() => T1Vnil()
| myoptn_cons(tm3) => t1erm_interp1(tm3, env0)
)
end // let // end of [T1Mif0]
//
|
T1Mfst(tm) => 
let
val tv = t1erm_interp1(tm, env0)
in
case- tv of
|
T1Vtup(tpl1, _) => tpl1
end // let // end of [T1Mfst]
|
T1Msnd(tm) => 
let
val tv = t1erm_interp1(tm, env0)
in
case- tv of
|
T1Vtup(_, tpl2) => tpl2
end // let // end of [T1Msnd]
|
T1Mtup(tm1, tm2) => T1Vtup(t1erm_interp1(tm1, env0), t1erm_interp1(tm2, env0))
|
T1Mseq(tmlst) =>
(
case- tmlst of
| mylist_nil() => T1Vnil()
| mylist_cons(tm1, ts1) =>
(
let
val
tv1 = t1erm_interp1(tm1, env0)
in
case- ts1 of
| mylist_nil() => tv1
| mylist_cons(_, _) => t1erm_interp1(T1Mseq(ts1), env0)
end
)
)
|
T1Mfix
(fnm, xnm, tpo_arg, tm1, tpo_res) => 
(
case- tpo_arg of
| myoptn_nil() => T1Vfix(t1ms, env0) 
| myoptn_cons(tp_arg) => T1Vfix(T1Mfix(fnm, xnm, myoptn_nil(), tm1, myoptn_nil()), env0)
)
//
|
T1Mlet(dcls, tm1) =>
let
val
env1 = t1dclist_interp1(dcls, env0)
in
t1erm_interp1(tm1, env1)
end
//
// | 
// T1Mlazy(tm1) =>
// T1Vlazy(t1erm_interp1(tm1, env0))
| 
T1Mlazy(tm1) =>
T1Vlazy(tm1, env0)
//
| 
T1Manno(tm1, tp1) => t1erm_interp1(tm1, env0)
|
T1Mnone(d1e) => T1Vnil()
)
(* ****** ****** *)

(* ****** ****** *)
implement
t1dclist_interp1(dcls, env0) =
case- dcls of
| mylist_nil() => env0
| mylist_cons(dcl1, dcls1) =>
(
let
val-
T1DCLbind(t1v, tm1) = dcl1
// t1v: t1var; tv1: t1Value
val
tv1 = t1erm_interp1(tm1, env0)
val
env1 = mylist_cons(@(t1v, tv1), env0)
in
t1dclist_interp1(dcls1, env1)
end
)
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_interp1.dats] *)
