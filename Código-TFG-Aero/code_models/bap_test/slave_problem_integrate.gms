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
Positive variable Last_F(F);
Positive variable First_F(F);
Positive variable comb2_aircraft(f1, F);

Equations
of,
flow_o(f1),
flow_a(f1),
flow(F),
inicio,
capacity,
capacity2(F),
inicio12,
cost_new_LOF,
total
;

of.. z=e=cost_duty - sum(F,Selected_F(F) * dual(F));

cost_new_LOF.. cost_duty=e=600+sum((f1,f2)$connec(f1,f2),conex(f1,f2)*(cost_connec(f1,f2)+20))+sum((F,c1,c2,t1,t2)$Flight(F, c1, c2, t1, t2), Price_comb(c1)*reposted_combustible(F)) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c1))) , First_F(F)*20) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c2))), Last_F(F)*50)  ;

flow_o(f1).. Selected_F(f1) - sum (f2$connec(f1,f2),conex(f1,f2))-Last_F(f1)=e= 0;
flow_a(f1).. Selected_F(f1) - sum (f3$connec(f3,f1), conex(f3, f1))-First_F(f1)=e= 0;
inicio.. sum(F, First_F(F))=e=1;
capacity.. sum(F, Last_F(F))=e=1;

flow(F).. reposted_combustible(F)+ sum(f1$connec(f1,F), comb2_aircraft(f1, F))=e=sum((c1, c2, t1, t2)$Flight(F, c1, c2, t1, t2), Selected_F(F)*consum_comb(c1, c2))+comb_aircraft(F);
capacity2(F).. reposted_combustible(F)+ sum(f1$connec(f1,F), comb_aircraft(f1))=l=120;
total(F).. sum(f1$connec(F,f1), comb2_aircraft(F, f1))=e=comb_aircraft(F) ;
inicio12(F).. comb_aircraft(F)=l=120*Selected_F(F);


option optcr = 0;
option limrow=12;
option MINLP = SBB;
model generation_duty /of, cost_new_LOF, flow_o, flow_a, inicio, flow, capacity, capacity2, inicio12, total/;
solve generation_duty minimizing z using mip;
display Selected_F.L, duties_test;

execute_unload 'Select_F' Selected_F;
execute_unload 'new_cost_Duty' cost_duty;
execute_unload 'Opt_duty' z;
execute_unload 'Repos_Duty' reposted_combustible;
