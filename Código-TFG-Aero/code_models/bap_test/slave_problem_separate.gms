$include set.gms
$include data.gms

execute_load "All_Duty" duties_test=duties_test;
execute_load 'cost_Duty' CostOfDurty_test=CostOfDurty_test;
execute_load 'V_Dual_F' dual=rescover_b_and_p.m;
execute_load 'V_Dual_D' v_dual_d=x;
execute_load 'Flight' Flight;
execute_load 'cost_connec' cost_connec;
execute_load 'connec' connec;

Binary variable Selected_F(F);
Binary variable conex(f2,f1);
Free variable z;
Free variable cost_duty;
Positive variable reposted_combustible(F);
Positive variable comb_aircraft(F);
Free variable cost_combustible;
Free variable comb2_aircraft(f1, F);
Positive variable Last_F(F);
Positive variable First_F(F);


Parameter Selected_F_c(F);
Selected_F_c(F)=0;
Parameter conex_c(f2,f1);
conex_c(f2,f1)=0

Parameter First_c(F);
First_c(F)=0;
Parameter Last_c(F);
Last_c(F)=0;


Equations
of_generate,
flow_o(f1),
flow_a(f1),
flow(F),
inicio,
capacity,
capacity2(F),
min_cost,
inicio12,
total,
reduce_cost
;

*Seleccionar vuelos
of_generate.. z=e=sum((f1,f2)$connec(f1,f2),conex(f1,f2)*(cost_connec(f1,f2)+20)) - sum(F,Selected_F(F) * dual(F)) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c1))) , First_F(F)*20) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c2))), Last_F(F)*50);

flow_o(f1).. Selected_F(f1) - sum (f2$connec(f1,f2),conex(f1,f2))-Last_F(f1)=e= 0;
flow_a(f1).. Selected_F(f1) - sum (f3$connec(f3,f1), conex(f3, f1))-First_F(f1)=e= 0;
inicio.. sum(F, First_F(F))=e=1;
capacity.. sum(F, Last_F(F))=e=1;


*reduced coste (tankering)
min_cost.. cost_duty=e=600+sum((f1,f2)$conex_c(f1,f2),(cost_connec(f1,f2)+20))+sum((F,c1,c2,t1,t2)$Flight(F, c1, c2, t1, t2), Price_comb(c1)*reposted_combustible(F)) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c1))) , First_c(F)*20) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c2))), Last_c(F)*50);

reduce_cost..z=e=cost_duty - sum(F,Selected_F_c(F) * dual(F));
flow(F)$Selected_F_c(F).. reposted_combustible(F)+ sum(f1$conex_c(f1,F), comb_aircraft(f1))=e=sum((c1, c2, t1, t2)$Flight(F, c1, c2, t1, t2), Selected_F_c(F)*consum_comb(c1, c2))+comb_aircraft(F);
capacity2(F)$Selected_F_c(F).. reposted_combustible(F)+ sum(f1$conex_c(f1,F), comb_aircraft(f1))=l=120;
total(F)$Selected_F_c(F).. sum(f1$conex_c(F,f1), comb2_aircraft(F, f1))=e=comb_aircraft(F) ;
inicio12(F)$Selected_F_c(F).. comb_aircraft(F)=l=120;


model generation_duty /of_generate, flow_a, flow_o, inicio, capacity/
model min_cost_duty/ min_cost, flow, capacity2, inicio12, total, reduce_cost/;

solve generation_duty minimizing z using mip;

display Selected_F.L, duties_test;
conex_c(f1,f2)=conex.l(f1,f2);
Selected_F_c(F)=Selected_F.l(F);
First_c(F)=First_F.l(F);
Last_c(F)=Last_F.l(F);
option optcr = 0;
solve min_cost_duty minimizing z using mip;

execute_unload 'Select_F' Selected_F;
execute_unload 'new_cost_Duty' cost_duty;
execute_unload 'Opt_duty' z;
execute_unload 'Repos_Duty' reposted_combustible;
