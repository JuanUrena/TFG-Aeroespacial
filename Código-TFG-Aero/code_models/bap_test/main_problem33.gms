$title main_problem33

$include set.gms
$include data.gms

*execute_load 'duty' duties_test;
*execute_load 'cost_duty' CostOfDurty_test;

Variables
Used_duti(D)
TotalCost
;

Binary variable Used_duti(D)
Free Variable TotalCost
;

Equations

of
rescover
*extra
;

*of.. TotalCost =e=  sum(($Active_duties(D)D),(CostOfDurty(D)+time_stop(D)+Cost_comb(D))*Used_duti(D));
of.. TotalCost =e=  sum(D,Used_duti(D)*CostOfDurty_test(D));
*of.. TotalCost =e=  sum(D,Used_duti(D));
rescover(F).. sum(D, duties_test(D,F)*Used_duti(D)) =g= 1;
*extra.. Used_duti('1')+Used_duti('7')=e=1;
*rescover(F).. sum(D, duties(D,F)*Used_duti(D)) =e= 1;
*USE CONOPT3

*option optcr = 0;
*option limrow=10;
*option RMIP=CONOPT3;
*option LP=CPLEX;

model main_problem33 /of, rescover/;
solve main_problem33 minimizing TotalCost using RMIP;
display TotalCost.l, Used_duti.l, Used_duti.m, rescover.m;
*solve main_problem minimizing TotalCost using RMIP;
*display TotalCost.l, Used_duti.l, Used_duti.m, rescover.m;