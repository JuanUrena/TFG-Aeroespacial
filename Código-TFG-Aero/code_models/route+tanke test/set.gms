set F Flight number /1*40/;
set C cities /A, B, C, D, E, F/;
set Base(C) /A,C/;

set N Nodes /1*100/;
set time /1*1810/;
*set time_less(time) /300*1810/;
set D duty /1*800/;
*set D_ini(D)/1,2,3,4,5,6,7/;
*set P pairing /1*5/;

alias(F, f1, f2, f3);
alias(C, c1, c2, c3,c4);
alias(time, t1, t2, t3, t4, t5, t6);
alias(D, d1);
alias(N,n1, N22);
display Base;

Parameter CostOfDurty_test(D);
