# Midterm Project

## 1 Work Results

### 1.1 Bug

Professor, this version still has one unreasonable ATS bug for part4 (part1, 2, 3 nobug). Could you have a look? If there's a solution, I will upload a new version.

```
BUILD/project_emitter_dats.c:1815:22: error: use of undeclared identifier 'PMVtmpltcstmat'
ATSINSmove(tmp46__1, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                     ^
BUILD/project_emitter_dats.c:1815:53: error: implicit declaration of function 'S2Ecst' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
ATSINSmove(tmp46__1, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                                    ^
BUILD/project_emitter_dats.c:1815:67: error: expected expression
ATSINSmove(tmp46__1, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                                                  ^
BUILD/project_emitter_dats.c:1815:40: error: use of undeclared identifier 'tostrptr_val'
ATSINSmove(tmp46__1, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                       ^
BUILD/project_emitter_dats.c:1815:60: error: use of undeclared identifier 't2cmp'
ATSINSmove(tmp46__1, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                                           ^
BUILD/project_emitter_dats.c:2437:22: error: use of undeclared identifier 'PMVtmpltcstmat'
ATSINSmove(tmp46__2, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                     ^
BUILD/project_emitter_dats.c:2437:53: error: implicit declaration of function 'S2Ecst' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
ATSINSmove(tmp46__2, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                                    ^
BUILD/project_emitter_dats.c:2437:67: error: expected expression
ATSINSmove(tmp46__2, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                                                  ^
BUILD/project_emitter_dats.c:2437:40: error: use of undeclared identifier 'tostrptr_val'
ATSINSmove(tmp46__2, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                       ^
BUILD/project_emitter_dats.c:2437:60: error: use of undeclared identifier 't2cmp'
ATSINSmove(tmp46__2, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                                           ^
BUILD/project_emitter_dats.c:3022:22: error: use of undeclared identifier 'PMVtmpltcstmat'
ATSINSmove(tmp46__3, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                     ^
BUILD/project_emitter_dats.c:3022:53: error: implicit declaration of function 'S2Ecst' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
ATSINSmove(tmp46__3, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                                    ^
BUILD/project_emitter_dats.c:3022:67: error: expected expression
ATSINSmove(tmp46__3, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                                                  ^
BUILD/project_emitter_dats.c:3022:40: error: use of undeclared identifier 'tostrptr_val'
ATSINSmove(tmp46__3, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                       ^
BUILD/project_emitter_dats.c:3022:60: error: use of undeclared identifier 't2cmp'
ATSINSmove(tmp46__3, PMVtmpltcstmat[0](tostrptr_val<S2Ecst(t2cmp)>)(arg1)) ;
                                                           ^
15 errors generated.
make: *** [BUILD/project_emitter_dats.o] Error 1
rm BUILD/project_atrans3_dats.c BUILD/project_emitter_dats.c
```

### 1.2 Features

I accomplished almost all features, except the "list" operator feature in part 4.

## 2 Work Introduction

### 2.1 Part I

Because I did pretty great work in assigns/04, what needs to be modified is not too much. I will introduce some new features I did in the midterm.

#### i. Develop additional primitive operators. For "list", I use T1Vcons to return it.

#### ii. Combine T1Mlam and T1Mlam2 in previous work. With myoptn, I can set "case" to deal with each other. Same as T1Mfix.

#### iii. For T1Mlet, I first interpret declaration list, then use the returned env to interpret t1erm.

#### iv. For dclinterp, I interprete each dcl but return the result with the new env.

#### v. For T1Mseq, I interprete each t1erm but only return the result of the last one.

### 3.2 Part II

#### i. For the list operators, I mostly type check them with the help of the new introduced T1Plist(type). Also, I added list feature to relevant function, such as "tpVar_occurs_t1ype" which needs "case" on each type.

#### ii. Combine T1Mlam and T1Mlam2 in previous work. In my interpretrer, I talked about each condition, in which types are given or not.

#### iii. T1Mfix changed a lot. Given the paras of inputs and outputs individually, I can compare them more conveniently and don't need to define new ones

#### iv. For T1Mlet, I first get all the types of declarations into a new env, then use the returned env to typecheck t1erm.

#### v. For dclist_type, I get the type of each dcl and conjact them into env.

### 3.3 Part III

#### i. This part is to translate LAMBDA into A-norm, so the overall design should follow the data type of LAMBDA. That is, design "t1erm_atrans1" to translate each LAMBDA type to a-norm.

#### ii. For T1Mlam, the instructions are empty and its box should be T2Vlam(cmp of body).

#### iii. For T1Mapp, the only difference with T1Mtup is to replace T2Itup with T2Ical.

#### iv. For T1Mif0, I introduce a new t2ins "T2Imov". For instance, if the else clause only has a value "1", then with T2Imov, I can connect the value with a register and return it. The core of implementation is to use attach the bnd var "bndmov" to bndlst.

#### v. For T1Mseq, I define a new function "t1ermseq_cal". This function will iterate the term list, concate every bnd into one "bnds", and return this bnds and the box of the last t1erm.

#### v. For T1Mfix, I let T2Varg(0) represent x and T2Varg(1) represent f, because later, in part 4, it's easier to tell x and f when outputting C code. Then, I translate the body with the new env containing the information of x and f.

#### vi. For T1Mopr, I make a new register for every operator operation, which follows the manner of a-norm.

### 3.4 Part IV

#### i. The input of this part is a-norm, so the overall design follows this 4 main types: t2cmp, t2box, t2ins, and t2bnd. The translator of each type is: temit3_cmp, temit3_box, temit3_ins, and temit3_bnd. 

#### ii. The interface of this translator is print_c() and temit3().

#### iii. I also introduce temit3_str(), temit3_int(), and temit3_btf() to individually output these 3 basic type.

#### iv. In temit3, I first output all the functions with temit3_function(), then others into main function by temit3_main().

#### v. I also introduced tuple type into run_time.h(in midterm project folder), but didn't figure out how to put into "list".
