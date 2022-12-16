(* ****** ****** *)
#staload "./project.sats"
#staload "./project_atrans3.dats"
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
typedef
t3funlst =
mylist(@(t1var, t2cmp))
(* ****** ****** *)
extern
fun
temit3
(t2trans: t2env): void
(* ****** ****** *)
extern
fun
temit3_function(t2trans: t2env):void
extern
fun
temit3_main(t2trans: t2env):void
(* ****** ****** *)
extern
fun
main_collect_regs(t2trans: t2env, regs: mylist(t2reg)): mylist(t2reg)
extern
fun
print_regs_main(regs: mylist(t2reg)):void
(* ****** ****** *)
extern
fun
find_funs_in_cmp(tcmp: t2cmp, tv: t1var, funs: t3funlst): t3funlst
extern
fun
find_funs_in_cmp_no_var(tcmp: t2cmp, funs: t3funlst): t3funlst
extern
fun
find_funs_in_dcls(dcls: t2env, funs: t3funlst): t3funlst
extern
fun
find_funs_in_bndlst(bndl: t2bndlst, funs: t3funlst): t3funlst
(* ****** ****** *)
extern 
fun
print_funs(funs: t3funlst):void
extern
fun
collect_regs(bndl: t2bndlst, regs: mylist(t2reg)): mylist(t2reg)
extern
fun
collect_regs_from_tins(bnd: t2bnd, regs: mylist(t2reg)): mylist(t2reg)
extern
fun
collect_regs_from_let(dcls: t2env, regs: mylist(t2reg)): mylist(t2reg)
extern
fun
collect_regs_from_if(bndl: t2bndlst, regs: mylist(t2reg)): mylist(t2reg)
extern
fun
print_regs(regs: mylist(t2reg)):void
extern
fun
print_regs_max(max_reg: t2reg):void
extern
fun
print_return(tbx: t2box):void
(* ****** ****** *)
extern
fun
print_bndl(bndl: t2bndlst, tv: t1var):void
extern
fun
print_mov(bnd: t2bnd, tv: t1var):void
extern
fun
print_cal(bnd: t2bnd, tv: t1var):void
extern
fun
print_opr(bnd: t2bnd, tv: t1var):void
extern
fun
print_fst(bnd: t2bnd, tv: t1var):void
extern
fun
print_snd(bnd: t2bnd, tv: t1var):void
extern
fun
print_tup(bnd: t2bnd, tv: t1var):void
extern
fun
print_if(bnd: t2bnd, tv: t1var):void
extern
fun
print_let(bnd: t2bnd, tv: t1var):void
extern
fun
print_dcls(dcls: t2env, tv: t1var):void
extern
fun
print_dcls_main(dcls: t2env, tv: t1var):void
(* ****** ****** *)
extern
fun
print_t2box(tbx: t2box, tv: t1var):void
extern 
fun
print_opr_detail(opr: t1opr, tbxs: t2boxlst, tv: t1var):void
(* ****** ****** *)


(* ****** ****** *)
implement
temit3(t2trans) = 
{
    val () = println!("#include \"runtime.h\"\n\n");
    val () = temit3_function(t2trans);
    val () = println!("\n");
    val () = println!("int main() \n{\n");
    val () = temit3_main(t2trans);
    val () = println!("");
    val () = println!("}\n")
}
(* ****** ****** *)

(* ****** ****** *)
implement
temit3_function
(t2trans) = 
let
val
funs = find_funs_in_dcls(t2trans, mylist_nil())
in
print_funs(funs)
end

implement
temit3_main
(t2trans) =
let
val regs = main_collect_regs(t2trans, mylist_nil())
val () = print_regs_main(regs)
val () = print_dcls(t2trans, "")
in
println!("return 0;")
end
(* ****** ****** *)

(* ****** ****** *)
implement
print_dcls_main(dcls, tv) =
case- dcls of
| mylist_cons(dcl, dcls) =>
let
val-(tvar, tcmp) = dcl
val-T2CMP(bndl, tbx) = tcmp
in
case- tbx of
| T2Vlam(_) => print_dcls_main(dcls, tv)
| _ =>
{
    val () = print_bndl(bndl, tv);
    val () = print!(tvar, " = ");
    val () = print_t2box(tbx, tv);
    val () = println!(";");
    val () = print_dcls_main(dcls, tv);
}
end
| mylist_nil() => println!("")
(* ****** ****** *)

(* ****** ****** *)
implement
main_collect_regs(t2trans, regs) =
case- t2trans of
| mylist_nil() => regs
| mylist_cons(dcl, dcls) =>
let
val-(tv, tcmp) = dcl
val-T2CMP(bndl, tbx) = tcmp
val regs = collect_regs(bndl, regs)
in
main_collect_regs(dcls, regs)
end

implement
print_regs_main(regs) =
case- regs of
| mylist_nil() => ()
| mylist_cons(_, _) =>
let
val () = print!("lamval1 ")
in
print_regs(regs)
end
(* ****** ****** *)

(* ****** ****** *)
implement
find_funs_in_cmp(tcmp, tv, funs) =
let
val-T2CMP(bndl, tbx) = tcmp
in
case- tbx of
| T2Vlam(tcmp1) =>
let
val funs = mylist_cons(@(tv, tcmp1), funs)
in
find_funs_in_cmp_no_var(tcmp1, funs)
end
//
| _ => find_funs_in_bndlst(bndl, funs)
end

implement
find_funs_in_cmp_no_var(tcmp, funs) =
let
val-T2CMP(bndl, tbx) = tcmp
in
case- tbx of
| T2Vlam(tcmp1) =>
let
val tv = t2lam_new()
val funs = mylist_cons(@(tv, tcmp1), funs)
in
find_funs_in_cmp_no_var(tcmp1, funs)
end
//
| _ => find_funs_in_bndlst(bndl, funs)
end

implement
find_funs_in_dcls(dcls, funs) =
case- dcls of
| mylist_nil() => funs
| mylist_cons(dcl, dcls) =>
let
val-(tv, tcmp) = dcl
val 
funs = find_funs_in_cmp(tcmp, tv, funs)
in
find_funs_in_dcls(dcls, funs)
end

implement
find_funs_in_bndlst(bndl, funs) =
case- bndl of
| mylist_nil() => funs
| mylist_cons(bnd, bndl) =>
let
val-T2BND(_, ins) = bnd
in
case- ins of
| T2Ilet(dcls) => find_funs_in_dcls(dcls, funs)
| _ => find_funs_in_bndlst(bndl, funs)
end
(* ****** ****** *)


// val () = println!()
(* ****** ****** *)
implement 
print_funs(funs) =
case- funs of
| mylist_nil() => ()
| mylist_cons(func, funs) =>
let
val-(tv, tcmp) = func
val () = println!("lamval1")
val () = println!(tv, "(lamval1 x)")
val () = println!("{\n")
val-T2CMP(bndl, tbx) = tcmp
// val-T2Vreg(ret) = tbx
// val () = println!("lamval1 ret", ret, ";")
val regs = collect_regs(bndl, mylist_nil())
val () = print!("lamval1 ")
val () = print_regs(regs)
val () = print_bndl(bndl, tv)
val () = print!("\n")
val () = print_return(tbx)
val () = println!("}\n")
in
print_funs(funs)
end

implement
collect_regs(bndl, regs) = 
case- bndl of
| mylist_nil() => mylist_reverse(regs)
| mylist_cons(bnd, bndl) =>
let
val regs = collect_regs_from_tins(bnd, regs)
in
collect_regs(bndl, regs)
end

implement
collect_regs_from_tins(bnd, regs) =
let
val-T2BND(reg, ins) = bnd
in
case- ins of
| T2Iif0(_, bndl1, bndl2) => 
let
val regs = collect_regs_from_if(bndl1, regs);
val regs = collect_regs_from_if(bndl2, regs);
in
mylist_cons(reg, regs)
end
| T2Ilet(dcls) => collect_regs_from_let(dcls, regs)
| _ => mylist_cons(reg, regs)
end

implement
collect_regs_from_let(dcls, regs) =
case- dcls of
| mylist_nil() => regs
| mylist_cons(dcl, dcls) =>
let
val-(tv, tcmp) = dcl
val-T2CMP(bndl, tbx) = tcmp
val regs = collect_regs(bndl, regs)
in
collect_regs_from_let(dcls, regs)
end

implement
collect_regs_from_if(bndl, regs) = 
let
val-mylist_cons(bnd, bndl) = bndl
in
case- bndl of
| mylist_nil() => 
let
val-T2BND(reg, ins) = bnd
in
    case- ins of
    | T2Iif0(_, bndl1, bndl2) =>
    let
    val regs = collect_regs_from_if(bndl1, regs);
    val regs = collect_regs_from_if(bndl2, regs);
    in
    regs
    end
    | T2Ilet(dcls) => collect_regs_from_let(dcls, regs)
    | _ => regs
// collect_regs_from_tins(bnd, regs)
end // end of mylist_nil()
| mylist_cons(_, _) => 
let
val-T2BND(reg, ins) = bnd
val regs = 
(
    case- ins of
    | T2Iif0(_, bndl1, bndl2) =>
    let
    val regs = collect_regs_from_if(bndl1, regs);
    val regs = collect_regs_from_if(bndl2, regs);
    in
    regs
    end
    | T2Ilet(dcls) => collect_regs_from_let(dcls, regs)
    | _ => mylist_cons(reg, regs)
)
in
collect_regs_from_if(bndl, regs)
end // end of mylist_cons
end // end of collect_regs_from_if

implement
print_regs(regs) = 
let
val-mylist_cons(reg, regs) = regs
val () = print!("tmp", reg)
in
case- regs of
| mylist_nil() => print!(";\n\n")
| mylist_cons(_, _) => let val () = print!(", ") in print_regs(regs) end
end

// implement
// print_regs_max(max_reg) =
// let
// in
// end

implement
print_return(tbx) = 
let
val () = print!("return tmp")
in
case- tbx of
| T2Vreg(reg) => println!(reg, ";")
| _ => ()
end
(* ****** ****** *)

(* ****** ****** *)
implement
print_bndl(bndl, tv) = 
case- bndl of
| mylist_nil() => ()
| mylist_cons(bnd, bndl) =>
let
val-T2BND(reg, ins) = bnd
val () = 
(
case- ins of
| T2Imov(_) => print_mov(bnd, tv)
| T2Ical(_, _) => print_cal(bnd, tv)
| T2Iopr(_, _) => print_opr(bnd, tv)
| T2Ifst(_) => print_fst(bnd, tv)
| T2Isnd(_) => print_snd(bnd, tv)
| T2Itup(_, _) => print_tup(bnd, tv)
| T2Iif0(_, _, _) => print_if(bnd, tv)
| T2Ilet(_) => print_let(bnd, tv)
)
in
print_bndl(bndl, tv)
end

implement
print_mov(bnd, tv) =
{
    val-T2BND(reg, ins) = bnd;
    val-T2Imov(tbx) = ins;
    val () = print!("tmp", reg, " = ");
    val () = print_t2box(tbx, tv);
    val () = println!(";");
}

implement
print_cal(bnd, tv) =
{
    val-T2BND(reg, ins) = bnd;
    val-T2Ical(tbx1, tbx2) = ins;
    val () = print!("tmp", reg, " = ");
    val () = print_t2box(tbx1, tv);
    val () = print!("(");
    val () = print_t2box(tbx2, tv);
    val () = println!(");");
}

implement
print_opr(bnd, tv) =
{
    val-T2BND(reg, ins) = bnd;
    val-T2Iopr(opr, tbxs) = ins;
    val () = print!("tmp", reg, " = ");
    val () = print_opr_detail(opr, tbxs, tv);
    val () = println!(";");
}

implement
print_fst(bnd, tv) =
{
    val-T2BND(reg, ins) = bnd;
    val-T2Ifst(tbx) = ins;
    val () = print!("tmp", reg, " = LAMVAL_fst(");
    val () = print_t2box(tbx, tv);
    val () = println!(");");
}

implement
print_snd(bnd, tv) =
{
    val-T2BND(reg, ins) = bnd;
    val-T2Isnd(tbx) = ins;
    val () = print!("tmp", reg, " = LAMVAL_snd(");
    val () = print_t2box(tbx, tv);
    val () = println!(");");
}

implement
print_tup(bnd, tv) =
{
    val-T2BND(reg, ins) = bnd;
    val-T2Itup(tbx1, tbx2) = ins;
    val () = print!("tmp", reg, " = LAMVAL_tup(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = println!(");");
}

implement
print_if(bnd, tv) =
{
    val-T2BND(reg_return, ins) = bnd;
    val-T2Iif0(tbx, bndl1, bndl2) = ins;
    val () = print!("if (((lamval1_int)");
    val () = print_t2box(tbx, tv);
    val () = println!(")->data)");
    val () = println!("{");
    val () = print_bndl(bndl1, tv);
    val () = println!("}");
    val () = println!("else");
    val () = println!("{");
    val () = print_bndl(bndl2, tv);
    val () = println!("}");
}

implement
print_let(bnd, tv) =
{
    val-T2BND(_, ins) = bnd;
    val-T2Ilet(dcls) = ins;
    val () = print_dcls(dcls, tv);
}

implement
print_dcls(dcls, tv) =
case- dcls of
| mylist_cons(dcl, dcls) =>
let
val-(tvar, tcmp) = dcl
val-T2CMP(bndl, tbx) = tcmp
in
case- tbx of
| T2Vlam(_) => print_dcls(dcls, tv)
| _ =>
{
    val () = print_bndl(bndl, tv);
    val () = println!("")
    val () = print!("lamval1 ", tvar, " = ");
    val () = print_t2box(tbx, tv);
    val () = println!(";\n");
    val () = print_dcls(dcls, tv)
}
end
| mylist_nil() => ()
(* ****** ****** *)

(* ****** ****** *)
implement
print_t2box(tbx, tv) = 
case- tbx of
| T2Vint(i) => print!("LAMVAL_int(", i, ")")
| T2Vbtf(b) => 
(
case- b of
| true => print!("LAMVAL_int(1)")
| false => print!("LAMVAL_int(0)")
)
| T2Vstr(s) => 
(
    case- s of
    | "\n" => print!("LAMVAL_str(\"\\n\")")
    | _ => print!("LAMVAL_str(\"", s, "\")")
)
| T2Vvar(v) => print!(v)
| T2Vfix(f) => print!(f)
| T2Varg(a) => print!("x")
| T2Vreg(r) => print!("tmp", r)
| T2Vlam(_) => ()
| T2Vnil => ()
(* ****** ****** *)

(* ****** ****** *)
implement
print_opr_detail(opr, tbxs, tv) = 
case- opr of
| "+" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_add(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| "-" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_sub(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| "*" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_mul(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| "/" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_div(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| "%" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_mod(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| "<" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_ilt(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| ">" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_igt(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| "=" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_eq(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| "<=" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_ile(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| ">=" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_ige(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| "!=" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_neq(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| "show" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("LAMOPR_show(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "print" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("LAMOPR_print(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "showval" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("LAMOPR_showval(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "list_nil" =>
{
    val () = print!("LAMOPR_lst_nil()");
}
| "list_cons" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val () = print!("LAMOPR_lst_cons(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(")");
}
| "list_nilq" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("LAMOPR_lst_nilq(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "list_consq" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("LAMOPR_lst_consq(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "list_uncons1" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("LAMOPR_lst_uncons1(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "list_uncons2" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("LAMOPR_lst_uncons2(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "strm_nil" =>
{
    val () = print!("strm_nil()");
}
| "strm_cons" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val-mylist_cons(tbx2, tbxs) = tbxs;
    val-mylist_cons(tbx3, tbxs) = tbxs;
    val () = print!("strm_cons(");
    val () = print_t2box(tbx1, tv);
    val () = print!(", ");
    val () = print_t2box(tbx2, tv);
    val () = print!(", ");
    val () = print_t2box(tbx3, tv);
    val () = print!(")");
}
| "strm_nilq" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("strm_nilq(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "strm_consq" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("strm_consq(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "strm_uncons1" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("strm_uncons1(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "strm_uncons2" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("strm_uncons2(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
| "$eval" =>
{
    val-mylist_cons(tbx1, tbxs) = tbxs;
    val () = print!("eval(");
    val () = print_t2box(tbx1, tv);
    val () = print!(")");
}
(* ****** ****** *)

(* ****** ****** *)


// (* end of [CS525-2022-Fall/Midterm_project_emitter.dats] *)
