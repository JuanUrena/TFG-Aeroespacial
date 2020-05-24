$include set.gms
$include data.gms

execute_load "All_Duty" duties_test=duties_test;
execute_load 'cost_Duty' CostOfDurty_test=CostOfDurty_test;
*execute_load 'V_Dual_F' dual=v_d.l;
*execute_load 'V_Dual_D' v_dual_d=Dual_d;
execute_load 'V_Dual_F' dual=rescover_b_and_p.m;
execute_load 'Flight' Flight;
execute_load 'cost_connec' cost_connec;
execute_load 'connec' connec;
display dual, v_dual_d, duties_test;

*Free variable Selected_duty(D);
*Free variable Selected_duty2(D);
*Free variable Selected_duty3(D);
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

*Positive Variable Aux;


Equations
*of_generate
*not_previous(D)
of_generate,
flow_o(f1),
flow_a(f1),
*flow_o1(f1,time)
*flow_a1(f1,time)
flow(F),
inicio,
capacity,
capacity2(F),
*inicio11,
*conexxx,
min_cost,
inicio12,
*cant_use_duty(D),
total,
reduce_cost
*cant_use_duty2
*cant_use_duty3
;

*of_generate.. z=e=sum(D,Selected_duty(D)*(sum(F,duties(D,F))+time_stop(D)-sum(F, dual(F)*duties(D,F))));
*of_generate.. z=e=sum(D,Selected_duty(D)*(CostOfDurty(D)-sum(F, dual(F)*duties(D,F))));
*of_generate.. z=e= 1 - sum(D, sum(F, dual(F)*duties(D,F)));
*Solo seleccionamos una
*unique.. sum(D,  Selected_duty(D))=e=1;
*not_previous(D).. Selected_duty(D)*Active_duties(D)=e=0;
*of_generate.. z=e=cost_duty - sum(F,Selected_F(F)* (dual(F)))- sum(D,Selected_duty(D)*v_dual_d(D)) ;
*-  sum(D$duties_test(D,F),v_dual_d(D) ) ));
of_generate.. z=e=sum((f1,f2)$connec(f1,f2),conex(f1,f2)*(cost_connec(f1,f2)+200)) - sum(F,Selected_F(F) * dual(F)) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c1))) , First_F(F)*1000) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c2))), Last_F(F)*5000);

reduce_cost..z=e=cost_duty - sum(F,Selected_F_c(F) * dual(F));

min_cost.. cost_duty=e=30000+sum((f1,f2)$conex_c(f1,f2),(cost_connec(f1,f2)+200))+sum((F,c1,c2,t1,t2)$Flight(F, c1, c2, t1, t2), Price_comb(c1)*reposted_combustible(F)) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c1))) , First_c(F)*1000) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c2))), Last_c(F)*5000)  ; ;

flow_o(f1).. Selected_F(f1) - sum (f2$connec(f1,f2),conex(f1,f2))-Last_F(f1)=e= 0;
*flow_o1(f1,time)$ot(f1,time).. Selected_F(f1) - sum (f2$connec(f1,f2),conex(f1,f2))=g= 0;

flow_a(f1).. Selected_F(f1) - sum (f3$connec(f3,f1), conex(f3, f1))-First_F(f1)=e= 0;
*flow_a(f1,time)$dt(f1,time).. Selectesd_F(f1) - sum (f3$connec(f3,f1), conex(f3, f1))=g=0;

*unique.. sum(F,Selected_F(F))=l=3;
*conexxx.. sum ((f1,f2)$connec(f1,f2), conex(f1,f2))=e= sum(F,Selected_F(F))-1;

inicio.. sum(F, First_F(F))=e=1;
capacity.. sum(F, Last_F(F))=e=1;

flow(F)$Selected_F_c(F).. reposted_combustible(F)+ sum(f1$conex_c(f1,F), comb_aircraft(f1))=e=sum((c1, c2, t1, t2)$Flight(F, c1, c2, t1, t2), Selected_F_c(F)*consum_comb(c1, c2))+comb_aircraft(F);


capacity2(F)$Selected_F_c(F).. reposted_combustible(F)+ sum(f1$conex_c(f1,F), comb_aircraft(f1))=l=6000;
total(F)$Selected_F_c(F).. sum(f1$conex_c(F,f1), comb2_aircraft(F, f1))=e=comb_aircraft(F) ;

*inicio11.. sum(F, First_F(F)*sum(f1$connec(f1,F), comb_aircraft(f1)))=e=0;

inicio12(F)$Selected_F_c(F).. comb_aircraft(F)=l=6000;

*Opcion 1 para anular la D, saber si la uso
*cant_use_duty(D)$CostOfDurty_test(D).. Selected_duty(D)=e=abs(sum(F$duties_test(D,F), Selected_F(F)) - sum(F, duties_test(D,F)));
*cant_use_duty3(D)$CostOfDurty_test(D).. Selected_duty3(D)=e=abs(sum(F$duties_test(D,F), Selected_F(F)) - sum(F, Selected_F(F)));
*cant_use_duty2(D)$CostOfDurty_test(D).. Selected_duty2(D)=e=1-(min(Selected_duty(D)+Selected_duty3(D),1));


*cant_use_duty(D)$(CostOfDurty_test(D)).. Selected_duty(D)=e=1-min(1,abs(sum(F$duties_test(D,F), Selected_F(F))- sum(F, Selected_F(F))  ));
*cant_use_duty2(D)$(Must_use_duty(D)).. Selected_duty(D)=e=1-min(1,abs(sum(F$duties_test(D,F), Selected_F(F))- sum(F, duties_test(D,F))  ));

*cant_use_duty(D)$(not Can_use_duty(D)).. sum(F$duties_test(D,F),1 - Selected_F(F))=g=1;
*cant_use_duty2(D).. Selected2_duty(D)=e=sum( F$duties_test(D,F), Selected_F(F));

*cant_use_duty(D).. Selected_duty(D) =e= not( sum(F$duties_test(D,F), Selected_F(F)) - sum(F, Selected_F(F)) );

option optcr = 0;
option limrow=36;
option MINLP = SBB;
model generation_duty /of_generate, flow_a, flow_o, inicio, capacity/
model min_cost_duty/ min_cost, flow, capacity2, inicio12, total, reduce_cost/;
*model generation_duty /of_generate, min_cost, flow_o, flow_a, conexxx, inicio, flow, capacity, capacity2, inicio11, cant_use_duty/;

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
