$title master_problem

$include set.gms
$include data.gms

execute_load 'All_Duty' duties_test=duties_test;
execute_load 'cost_Duty' CostOfDurty_test=CostOfDurty_test;

execute_load 'Can_duty' Can_use_duty;
execute_load 'Must_Duty' Must_use_duty;

execute_load 'Flight' Flight;

Scalar num_F;
execute_load 'Actual_num_F' num_F;
*Can_use_duty(D)=1;
*Must_use_duty(D)=0;
*Must_use_duty('1')=1;
Variables
Used_duti(D)
TotalCost
r
;

Positive variable Used_duti(D)
Free Variable TotalCost
Free Variable r
;

Equations

of_b_and_p
rescover_b_and_p(F)
must_duty(D)
can_duty(D)
n_aero
n_aero2
;

of_b_and_p.. TotalCost =e=  sum(D,CostOfDurty_test(D)*Used_duti(D))- r*400;
*of_b_and_p.. TotalCost =e=  sum((D)$Active_duties(D), Used_duti(D));
rescover_b_and_p(F)$(ord(F)<=num_F).. sum(D, duties_test(D,F)*Used_duti(D)) =e= 1;

must_duty(D)$(Must_use_duty(D)).. Used_duti(D) =e= Must_use_duty(D);
can_duty(D)$(not Can_use_duty(D)) .. Used_duti(D) =e=Can_use_duty(D);

n_aero.. r=l=15;
n_aero2.. r=l=sum(D, Used_duti(D));

option optcr = 0;
option limrow=8;
model main_problem_duty_and_price /of_b_and_p, rescover_b_and_p, must_duty, can_duty, n_aero, n_aero2/;


solve main_problem_duty_and_price minimizing TotalCost using LP;
*display TotalCost.l, Used_duti.l, rescover_b_and_p.m, must_duty.m, can_duty.m, Used_duti.m ;
*Parameter x(D);
*x(D)=0;
*x(D)= Used_duti.M(D)+must_duty.m(D)+can_duty.m(D);
*display x;
execute_unload 'Used_duty' Used_duti;
execute_unload 'V_Dual_F' rescover_b_and_p;
execute_unload 'Cost_Operation' TotalCost;
