$include set.gms
$include data_test_flight.gms
$setglobal ide "ide=%gams.ide% lo=%gams.lo% errorlog=%gams.errorlog% errmsg=1"

Scalar num_F;
Scalar iterations_duty;
Scalar time_ini;
Scalar time_fin;
Scalar sol_incum;
sol_incum=0;
iterations_duty=0;
num_F=0;

for(num_F=40 to 40 by 10,

       loop ((F,c1,c2,t1,t2)$(Flight_All(F, c1, c2, t1, t2) and ord(F)<=num_F),
                Flight(F, c1, c2, t1, t2)=1
       );

       execute_unload 'Flight' Flight;
       execute_unload 'Actual_num_F' num_F;
       time_ini=jnow;
       execute "gams branch_and_price.gms %ide%";
       time_fin=jnow;

       execute_load 'Num_duty' iterations_duty=d_act;

       execute_load 'Cost_solution' sol_incum;

       Iteration_Solution(F)$(ord(F)=num_F)=iterations_duty-num_F;
       Time_Solution(F)$(ord(F)=num_F)=(time_fin-time_ini)*24*3600;
       Cost_Solution(F)$(ord(F)=num_F)=sol_incum;
);
display Iteration_Solution, Time_Solution, Cost_Solution;



