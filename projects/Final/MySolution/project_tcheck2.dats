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
(*
typedef
t1ctx = mylist(@(t1var, t1ype))
*)
(* ****** ****** *)
//
extern
fun
t1erm_oftype1
(t1m0: t1erm, ctx0: t1ctx): t1ype
//
extern
fun
t1dclist_oftype1
(dcls: t1dclist, ctx0: t1ctx): t1ctx
//
(* ****** ****** *)
//
implement
t1erm_oftype0(t1m0) =
t1erm_oftype1(t1m0, mylist_nil())
//
(* ****** ****** *)
//
implement
t1dclist_oftype0
  (dcls) =
let
val
ctx0 = mylist_nil()
in t1dclist_oftype1(dcls, ctx0) end
//
(* ****** ****** *)


(* ****** ****** *)
(* ****** ****** *)
(* ****** ****** *)
// Yanchong: My work begins here...
(* ****** ****** *)
(* ****** ****** *)
extern
fun
t1ermlst_oftype1
(tms: t1ermlst, xts: t1ctx): t1ypelst
extern
fun
t1erm_oftype1_var(t1erm, t1ctx): t1ype
extern
fun
t1erm_oftype1_opr(t1erm, t1ctx): t1ype
(* ****** ****** *)
(* ****** ****** *)
extern
fun
tpVar_new(): tpVar
extern
fun
t1ype_new_ext(): t1ype
extern
fun
t1ype_new_fun(): t1ype
extern
fun
t1ype_new_tup(): t1ype
extern
fun
t1ype_eval(t1ype): t1ype
(* ****** ****** *)
(* ****** ****** *)
extern
fun
tpVar_equal_ref
(X1: tpVar, X2: tpVar): bool
overload == with tpVar_equal_ref
(* ****** ****** *)
(* ****** ****** *)
extern
fun
tpVar_occurs_t1ype
(X1: tpVar, tp2: t1ype): bool
//
extern
fun
t1ype_unify
(tp1: t1ype, tp2: t1ype): bool
overload unify with t1ype_unify
//
extern
fun
t1ype_unify_var1(tpVar, t1ype): bool
extern
fun
t1ype_unify_var2(t1ype, tpVar): bool
(* ****** ****** *)


(* ****** ****** *)
implement
t1ermlst_oftype1(tms, xts) =
(
case+ tms of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(tm1, tms) =>
mylist_cons
(t1erm_oftype1(tm1, xts), t1ermlst_oftype1(tms, xts))
)
(* ****** ****** *)
implement
t1erm_oftype1_var
(tm0, xts) =
let
val-T1Mvar(x) = tm0
in
find(xts) where
{
fun find(xts: t1ctx): t1ype =
(
case- xts of
| mylist_cons(xt, xts) =>
  (if x = xt.0 then xt.1 else find(xts))
)
}
end (*let*) // end of [t1erm_oftype1_var(tm0,xts)]
(* ****** ****** *)
implement
t1erm_oftype1_opr
(tm0, xts) =
let
//
val-
T1Mopr(opr, tms) = tm0
val
tps = t1ermlst_oftype1(tms, xts)
//
in//let
(
case- opr of
//
| "+" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pint
end
| "-" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pint
end
| "*" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pint
end
| "/" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pint
end
| "%" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pint
end
//
| "<" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbool
end
| ">" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbool
end
| "=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbool
end
| "<=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbool
end
| ">=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbool
end
| "!=" =>
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val-true = t1ype_unify(tp1, T1Pint)
val-true = t1ype_unify(tp2, T1Pint) in T1Pbool
end
(* ****** ****** *)
// Yanchong Peng: This is the implementation of type checking for show
| "show" =>
let
val-
mylist_cons(tp1, tps) = tps
val-true = t1ype_unify(tp1, T1Pstring) 
in
T1Pnil
end
| "print" =>
let
val-
mylist_cons(tp1, tps) = tps
in
if t1ype_unify(tp1, T1Pint)
then T1Pnil
else if t1ype_unify(tp1, T1Pbool)
then T1Pnil
else if t1ype_unify(tp1, T1Pstring)
then T1Pnil
else
(
let
val-T1Plist(tp2) = tp1
in
T1Pnil
end
)
end
| "showval" =>
let
val-
mylist_cons(tp1, tps) = tps
val-true = t1ype_unify(tp1, T1Pint) 
in
T1Pnil
end
(* ****** ****** *)
//
| "list_nil" => // () -> list(X) // list-nil
let
val
tp1 = t1ype_new_ext()
in
T1Plist(tp1)
end
| "list_cons" => // (X, list(X)) -> list(X) // list-cons
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
// val () = print(tp1)
// val () = print(tp2)
val tp3 = t1ype_new_ext()
val-true = t1ype_unify(tp2, T1Plist(tp3))
val-true = t1ype_unify(tp1, tp3)
in
T1Plist(tp1)
end
| "list_nilq" => // list(X) -> bool // list-nil-test
let
val-
mylist_cons(tp1, tps) = tps
val-
T1Plist(tp2) = tp1
in
T1Pbool
end
| "list_consq" => // list(X) -> bool // list-cons-test
let
val-
mylist_cons(tp1, tps) = tps
val-
T1Plist(tp2) = tp1
in
T1Pbool
end
| "list_uncons1" => // list(X) -> X // list-head
let
val-
mylist_cons(tp1, tps) = tps
val-
T1Plist(tp2) = tp1
in
tp2
end
| "list_uncons2" => // list(X) -> list(X) // list-tail
let
val-
mylist_cons(tp1, tps) = tps
val-
T1Plist(tp2) = tp1
in
tp1
end
| "strm_nil" => // () -> strm(X) // strm-nil
let
val
tp1 = t1ype_new_ext()
in
T1Pstrm(tp1)
end
| "strm_cons" => // (X, lazy(strm(X))) -> strm(X) // strm-cons
let
val-
mylist_cons(tp1, tps) = tps
val-
mylist_cons(tp2, tps) = tps
val tp3 = t1ype_new_ext()
val-true = t1ype_unify(tp2, T1Plazy(T1Pstrm(tp3)))
val-true = t1ype_unify(tp1, tp3)
in
T1Pstrm(tp1)
end
| "strm_nilq" => // strm(X) -> bool // strm-nil-test
let
val-
mylist_cons(tp1, tps) = tps
val tp2 = t1ype_new_ext()
val-true = t1ype_unify(tp1, T1Pstrm(tp2))
in
T1Pbool
end
| "strm_consq" => // strm(X) -> bool // strm-cons-test
let
val-
mylist_cons(tp1, tps) = tps
val tp2 = t1ype_new_ext()
val-true = t1ype_unify(tp1, T1Pstrm(tp2))
in
T1Pbool
end
| "strm_uncons1" => // strm(X) -> X // strm-head
let
val-
mylist_cons(tp1, tps) = tps
val tp2 = t1ype_new_ext()
val-true = t1ype_unify(tp1, T1Pstrm(tp2))
in
tp2
end
| "strm_uncons2" => // strm(X) -> lazy(strm(X)) // strm-tail
let
val-
mylist_cons(tp1, tps) = tps
val tp2 = t1ype_new_ext()
val-true = t1ype_unify(tp1, T1Pstrm(tp2))
in
T1Plazy(T1Pstrm(tp2))
end
| "$eval" => // lazy(X) -> X // eval
let
val-
mylist_cons(tp1, tps) = tps
val tp2 = t1ype_new_ext()
val-true = t1ype_unify(tp1, T1Plazy(T1Pstrm(tp2)))
in
T1Pstrm(tp2)
end
)
end (*let*) // end of [t1erm_oftype1_opr(tm0, xts)]
(* ****** ****** *)


(* ****** ****** *)
implement
tpVar_new() =
ref(myoptn_nil())
//
implement
t1ype_new_ext() =
T1Pext(tpVar_new())
//
implement
t1ype_new_fun() =
T1Pfun
(t1ype_new_ext(), t1ype_new_ext())
//
implement
t1ype_new_tup() =
T1Ptup
(t1ype_new_ext(), t1ype_new_ext())
//
implement
t1ype_eval(tp0) =
(
case+ tp0 of
|
T1Pext(X0) =>
(
case+ !X0 of
|
myoptn_nil() => tp0
|
myoptn_cons(tp1) => t1ype_eval(tp1)
)
| _ (*non-T1Pext*) => tp0
)
(* ****** ****** *)

(* ****** ****** *)
//
implement
tpVar_equal_ref
(X1, X2) =
(ref_get_ptr(X1) = ref_get_ptr(X2))
(* ****** ****** *)


(* ****** ****** *)
implement
tpVar_occurs_t1ype
(X1, tp2) =
let
val tp2 = t1ype_eval(tp2)
in
case+ tp2 of
|
T1Pnil _ => false
|
T1Pbas _ => false
|
T1Pext(X2) => (X1 == X2)
|
T1Pfun(tp21, tp22) =>
(tpVar_occurs_t1ype(X1, tp21) || tpVar_occurs_t1ype(X1, tp22))
|
T1Ptup(tp21, tp22) =>
(tpVar_occurs_t1ype(X1, tp21) || tpVar_occurs_t1ype(X1, tp22))
|
T1Plist(tp21) =>
tpVar_occurs_t1ype(X1, tp21)
|
T1Plazy(tp21) =>
tpVar_occurs_t1ype(X1, tp21)
|
T1Pstrm(tp21) =>
tpVar_occurs_t1ype(X1, tp21)
|
T1Pnone _ => false
end // end of [let] // end of [tpVar_occurs_t1ype]
//
implement
t1ype_unify
(tp1, tp2) =
let
val tp1 = t1ype_eval(tp1)
val tp2 = t1ype_eval(tp2)
in//let
case
(tp1, tp2) of
|
(T1Pext(X1), _) => t1ype_unify_var1(X1, tp2)
|
(_, T1Pext(X2)) => t1ype_unify_var2(tp1, X2)
|
(T1Pbas nm1, T1Pbas nm2) => (nm1 = nm2)
|
(T1Pfun(tp11, tp12), T1Pfun(tp21, tp22)) =>
(t1ype_unify(tp11, tp21) && t1ype_unify(tp12, tp22))
|
(T1Ptup(tp11, tp12), T1Ptup(tp21, tp22)) =>
(t1ype_unify(tp11, tp21) && t1ype_unify(tp12, tp22))
|
(T1Plist(tp11), T1Plist(tp21)) => t1ype_unify(tp11, tp21)
|
(T1Plazy(tp11), T1Plazy(tp21)) => t1ype_unify(tp11, tp21)
|
(T1Pstrm(tp11), T1Pstrm(tp21)) => t1ype_unify(tp11, tp21)
| (_, _) => false 
end // end of [let] // end of [t1ype_unify(tp1, tp2)]
//
implement
t1ype_unify_var1
(X1, tp2) =
// [tp2] is already evaluated!
(
case+ tp2 of
|
T1Pext(X2) =>
if
X1 == X2
then true
else (!X1 := myoptn_cons(tp2); true)
| _ =>
if
tpVar_occurs_t1ype(X1, tp2)
// X1 is contained in tp2
then false else (!X1 := myoptn_cons(tp2); true)
)
//
implement
t1ype_unify_var2
(tp1, X2) =
(
if
tpVar_occurs_t1ype(X2, tp1)
// X2 is contained in tp1
then false else (!X2 := myoptn_cons(tp1); true)
)
(* ****** ****** *)

(* ****** ****** *)
implement
t1erm_oftype1
(tm0: t1erm, xts: t1ctx) =
(
case tm0 of
//
| T1Mnil _ => T1Pnil
//
| T1Mint _ => T1Pint
| T1Mbtf _ => T1Pbool
| T1Mstr _ => T1Pstring
//
| T1Mvar _ =>
t1erm_oftype1_var(tm0, xts)
//
| 
T1Mlam
(xnm, tpo1, tm1) => 
(
case- tpo1 of
| myoptn_nil() => 
(
let
val tp1 = t1ype_new_ext()
val tp2 =
t1erm_oftype1
(tm1, mylist_cons(@(xnm, tp1), xts)) 
in//let
T1Pfun(tp1, tp2)
end
)
| myoptn_cons(tp1) =>
(
let
val tp2 =
t1erm_oftype1
(tm1, mylist_cons(@(xnm, tp1), xts)) 
in
T1Pfun(tp1, tp2)
end
)
)
//
| 
T1Mapp(tm1, tm2) =>
let
val tp1 =
t1erm_oftype1(tm1, xts)
val tp2 =
t1erm_oftype1(tm2, xts)
//
val tp1 =
let
  val tp1 =
  t1ype_eval(tp1)
in
  case+ tp1 of
  |
  T1Pext X1 =>
  let
  val tp1 =
  t1ype_new_fun()
  in
  !X1 :=
  myoptn_cons(tp1); tp1
  end
  | _ (*non-T1Pext*) => tp1
end : t1ype // end-val
//
val-
T1Pfun(tp11, tp12) = tp1
//
val-true = t1ype_unify(tp11, tp2) in tp12
end // let // end of [T1Papp(tm1, t2)]
//
|
T1Mopr _ => t1erm_oftype1_opr(tm0, xts)
//
|
T1Mif0
(tm1, tm2, tmopt) =>
let
val tp1 =
t1erm_oftype1(tm1, xts)
val tp2 =
t1erm_oftype1(tm2, xts)
val-true =
t1ype_unify(tp1, T1Pbool)
in 
case- tmopt of
| myoptn_nil() => tp2
| myoptn_cons(tm3) => 
(
let
val tp3 =
t1erm_oftype1(tm3, xts)
val-true = t1ype_unify(tp2, tp3) 
in
tp2
end
)
end // let // end of [T1Mif0(tm1, tm2, tmopt)]
//
| T1Mfst(tm) =>
let
val tp = t1erm_oftype1(tm, xts)
val-true = t1ype_unify(tp, t1ype_new_tup())
in
case- tp of
| T1Ptup(tp1, tp2) => tp1
| T1Pext(_) => t1ype_new_ext()
end
| T1Msnd(tm) =>
let
val tp = t1erm_oftype1(tm, xts)
val-true = t1ype_unify(tp, t1ype_new_tup())
in
case- tp of
| T1Ptup(tp1, tp2) => tp2
| T1Pext(_) => t1ype_new_ext()
end
| T1Mtup(tm1, tm2) =>
let
val tp1 = t1erm_oftype1(tm1, xts)
val tp2 = t1erm_oftype1(tm2, xts)
in
T1Ptup(tp1, tp2)
end
//
| T1Mseq(tmlst) =>
(
case- tmlst of
| mylist_nil() => T1Pnil
| mylist_cons(tm1, ts1) =>
(
let
val
tp1 = t1erm_oftype1(tm1, xts)
in 
case- ts1 of
| mylist_nil() => tp1
| mylist_cons(_, _) => t1erm_oftype1(T1Mseq(ts1), xts)
end
)
)
//
| T1Mfix
(fnm, xnm, tpo_arg, tm1, tpo_res) => 
(
case- tpo_arg of
| myoptn_nil() =>
(
case- tpo_res of
| myoptn_nil() =>
(
let 
val
tp1 = t1ype_new_fun()
val-
T1Pfun(tp11, tp12) = tp1
val 
tp2 =
t1erm_oftype1
(tm1, mylist_cons(@(fnm, tp1), mylist_cons(@(xnm, tp11), xts)))
val-true = t1ype_unify(tp12, tp2)
in
T1Pfun(tp11, tp12)
end
)
| myoptn_cons(tp_res) =>
(
let
val
tp_arg = t1ype_new_ext()
val
tp1 = T1Pfun(tp_arg, tp_res)
val
tp2 = 
t1erm_oftype1
(tm1, mylist_cons(@(fnm, tp1), mylist_cons(@(xnm, tp_arg), xts)))
val-true = t1ype_unify(tp_res, tp2)
in
tp1
end
)
) // End of [tpo_arg = myoptn_nil]
| myoptn_cons(tp_arg) =>
(
case- tpo_res of
| myoptn_nil() =>
(
let
val
tp_res = t1ype_new_ext()
val
tp1 = T1Pfun(tp_arg, tp_res)
val 
tp2 = 
t1erm_oftype1
(tm1, mylist_cons(@(fnm, tp1), mylist_cons(@(xnm, tp_arg), xts))) 
val-true = t1ype_unify(tp_res, tp2)
in
tp1
end
)
| myoptn_cons(tp_res) =>
(
let
val
tp1 = T1Pfun(tp_arg, tp_res)
val 
tp2 = 
t1erm_oftype1
(tm1, mylist_cons(@(fnm, tp1), mylist_cons(@(xnm, tp_arg), xts))) 
val-true = t1ype_unify(tp_res, tp2)
in
tp1
end
)
) // End of [tpo_arg = myoptn_cons]
) // End of [T1Mfix]
// 
| T1Mlet(dcls, tm1) =>
let
val 
xts1 = t1dclist_oftype1(dcls, xts)
in 
t1erm_oftype1(tm1, xts1)
end
//
| 
T1Mlazy(tm1) =>
T1Plazy(t1erm_oftype1(tm1, xts))
//
| T1Manno(tm1, tp1) =>
let
val tp2 = t1erm_oftype1(tm1, xts)
val-true = t1ype_unify(tp2, tp1)
in
tp1
end 
//
| T1Mnone(d1e) => T1Pnil
)
//
(* ****** ****** *)

(* ****** ****** *)
implement
t1dclist_oftype1
(dcls: t1dclist, xts: t1ctx) =
(
case- dcls of
| mylist_nil() => xts
| mylist_cons(dcl1, dcls1) =>
let
// t1v: t1var
val-
T1DCLbind(t1v, tm1) = dcl1
val
tp1 = t1erm_oftype1(tm1, xts)
in
t1dclist_oftype1(dcls1, mylist_cons(@(t1v, tp1), xts))
end
)
(* ****** ****** *)

(* end of [CS525-2022-Fall/Midterm_project_tcheck2.dats] *)
