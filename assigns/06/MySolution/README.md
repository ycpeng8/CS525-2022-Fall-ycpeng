Everything done!

### Argument of P1

I generate all the natural number pairs whose sum equal 0, then 1,2,3,... in ascending order.
In this way, we can traverse every value of either of two arguments, avoiding infinitely traversing (0, 0), (0, 1), (0, 2), ...
For instance, in my test, the order of generated pair should be:
p = (0, 0)          sum: 0
p = (0, 1)          sum: 1
p = (1, 0)          sum: 1
p = (0, 2)          sum: 2
p = (1, 1)          sum: 2
p = (2, 0)          sum: 2
p = (0, 3)          sum: 3
p = (1, 2)          sum: 3
p = (2, 1)          sum: 3
p = (3, 0)          sum: 3
p = (0, 4)          sum: 4

### Does your solution type-check?

No

### Does your solution compile?

The way of compiling has been written as follows. Every answer will be printed together.

### Test my homework

```
% make test
```

### Clean

```
% make cleanall
```