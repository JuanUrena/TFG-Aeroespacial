$title duality_problem
$include set.gms
$include data.gms

execute_load "All_Duty" duties_test=duties_test;
execute_load 'cost_Duty' CostOfDurty_test=CostOfDurty_test;
execute_load 'Can_duty' Can_use_duty;
execute_load 'Must_Duty' Must_use_duty;

Variables
v_d(F),
v2_d(F),
m_d(D),
m2_d(D),
c_d(D),
c2_d(D),
dual_max;


Positive variable v_d(F);
Positive variable v2_d(F);
Positive variable m_d(D);
Positive variable m2_d(D);
Positive variable c_d(D);
Positive variable c2_d(D);
Free variable dual_max;

Equation
o_f_dual
cost_dual
*must
*can
;

*o_f.. z=e=sum(F, v_d(F) + sum(D$(duties_test(D,F) and Must_use_duty(D)), z_d(F)) + sum(D$(duties_test(D,F) and Can_use_duty(D)), - t_d(F)) );
o_f_dual.. dual_max=e=sum(F, v_d(F) - v2_d(F)) + sum(D$Must_use_duty(D), m_d(D))- sum(D$Must_use_duty(D), m2_d(D));
*o_f.. z=e=sum(F, v_d(F));
cost_dual(D).. sum(F$duties_test(D,F), v_d(F) - v2_d(F))+ Must_use_duty(D) * (m_d(D) - m2_d(D)) + (c_d(D)-c2_d(D)) *(1-Can_use_duty(D)) =l=CostOfDurty_test(D);

*must(D)$Must_use_duty(D) .. m_d(D)=e=CostOfDurty_test(D);
*can(D)$(not Can_use_duty(D)) .. c_d(D)=e=CostOfDurty_test(D);

*        + sum(F$duties_test(D,F), -t_d(F)) =l= CostOfDurty_test(D);
*cost(D).. sum(F$duties_test(D,F), v_d(F))=l= CostOfDurty_test(D);
*must(D).. sum (F$(duties_test(D,F) and Must_use_duty(D)),v_d(F))=e=CostOfDurty_test(D)*Must_use_duty(D);

*can(D).. sum (F$(duties_test(D,F) and not(Can_use_duty(D))),v_d(F))=e=CostOfDurty_test(D)*Must_use_duty(D);
option limrow=12;
model duality_problem /o_f_dual, cost_dual/;
solve duality_problem using LP maximizing dual_max;
display v_d.l, v2_d.l, m_d.l, c_d.l, m2_d.l, c2_d.l;
Dual_d(D)=m_d.l(D)+c_d.l(D)+m2_d.l(D)+c2_d.l(D);
display Dual_d, duties_test;
execute_unload 'V_Dual_F' v_d;
execute_unload 'V_Dual_D' Dual_d;
