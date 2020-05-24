$include set.gms
$setglobal ide "ide=%gams.ide% lo=%gams.lo% errorlog=%gams.errorlog% errmsg=1"



Scalar num_F;
Scalar iterations_duty;
Scalar time_ini;
Scalar time_fin;
Scalar sol_incum;
sol_incum=0;
iterations_duty=0;
num_F=100;

Parameter Time_Solution(F);
Time_Solution(F)=0;

Parameter Iteration_Solution(F);
Iteration_Solution(F)=0;

Parameter Cost_Solution(F);
Cost_Solution(F)=0;


execute_unload 'Actual_num_F' num_F;
time_ini=jnow;
execute "gams master_master.gms %ide%";
time_fin=jnow;

execute_load 'Num_duty' iterations_duty=d_act;

execute_load 'Cost_solution' sol_incum;

Iteration_Solution(F)$(ord(F)=num_F)=iterations_duty-num_F;
Time_Solution(F)$(ord(F)=num_F)=(time_fin-time_ini)*24*3600;
Cost_Solution(F)$(ord(F)=num_F)=sol_incum;

display Iteration_Solution, Time_Solution, Cost_Solution;



