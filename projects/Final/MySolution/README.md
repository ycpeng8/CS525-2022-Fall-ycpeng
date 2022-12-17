# Final Project

## Report: \<not ready\>

## Presentation: \<not ready\>

## Work Accomplished

### Part I. lazy-evalutation has been finished

### Part II. Closure-Conversion is partly finished: "atrans3" done, but "emitter" isn't finished

## How to compile:

1. In Mysolution folder, use "make" to compile the compiler

2. Use "./project TEST/lazy_test.dats" to test what you want

3. The outputs include: t1ds(t1erm), interpreter output, type checking output, atrans, and C code

> Because emitter for closure-conversion is not finished, there will be an error when outputing C code (Everthing else works well)

4. Copy the output C code, enter TEST/mytest folder, put the C code into a new C file such as lazy-test.c

> The reason why you have to put C code in this folder, is that there's runtime.h here and the output C code cannot run without it. (Of course you can copy/paste runtime.h to other folders...)

5. run "gcc -o lazy_test lazy_test.c" to compile C code.

6. run "./lazy_test" to test output C code.

## Please refer to the report to know the implementation design and detail
