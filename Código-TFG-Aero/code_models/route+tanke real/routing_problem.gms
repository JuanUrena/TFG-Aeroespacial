$title main_problem_duty_and_price

$include set.gms
$include data.gms
$include data_master.gms

execute_load 'All_Duty' duties_test=duties_test;
execute_load 'cost_Duty' CostOfDurty_test=CostOfDurty_test;

execute_load 'Can_duty' Can_use_duty;
execute_load 'Must_Duty' Must_use_duty;

execute_load 'Flight' Flight;
execute_load 'cost_connec' cost_connec;
execute_load 'connec' connec;

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
Free Variable FinalCost;
Free Variable r
Binary variable use_conec(F,f1);
Binary variable Last_F(F);
Binary variable First_F(F);

Equations

of
flow_o(F)
flow_a(F)
flow_f(F)
res_cost
res_r_1
res_r_2
;

of.. FinalCost =e=  TotalCost- r*20000;

res_cost.. TotalCost=e=sum(F,First_F(F)*30000)+sum((f1,f2)$connec(f1,f2),use_conec(f1,f2)*(cost_connec(f1,f2)+200)) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c1))) , First_F(F)*1000) + sum((F,c1,c2,t1,t2)$(Flight(F, c1, c2, t1, t2) and not(Base(c2))), Last_F(F)*5000);

flow_a(f1)..  - sum (f2$connec(f1,f2),use_conec(f1,f2))+First_F(f1)+sum (f2$connec(f2,f1),use_conec(f2,f1))-Last_F(f1)=e= 0;

flow_o(f1).. sum (f2$connec(f2,f1),use_conec(f2,f1))+First_F(f1)=e=1;
flow_f(f1).. sum (f2$connec(f1,f2),use_conec(f1,f2))+Last_F(f1)=e=1;

res_r_1.. r=l=25;
res_r_2.. r=l=sum(F, First_F(F));
option optcr = 0;
model main_problem_duty_and_price /all/;
solve main_problem_duty_and_price minimizing FinalCost using MIP;
display  use_conec.l, Last_F.l, First_F.l

Scalar Fl;
Scalar Fl2;
Scalar i;
i=4;
display i;
Scalar t_LOF;
t_LOF=sum(F, First_F.l(F));

Parameter FF(F);
Scalar b;
Parameter LOF(D,F);
LOF(D,F)=0;
Parameter con_LOF(D,F,f1);
con_LOF(D,F,f1)=0;
for (i=1 to t_LOF by 1,
         loop(F$(First_F.l(F)),
                 LOF(D,F)$(ord(D)=i)=1;
                 FF(F)=1;
                 First_F.l(F)=0;
                 Fl=ord(F);
                 b=1;
                 if(Last_F.l(F),
                         b=0;
                 );
                 while (b,
                      loop((f2,f1)$(ord(f2)=Fl),
                              if(use_conec.l(f2,f1),
                                      Fl2=ord(f1);
                                      con_LOF(D,f2,f1)$(ord(D)=i)=1;
                                      LOF(D,f1)$(ord(D)=i)=1;
                                      display Fl, Fl2;
                                      Fl=Fl2;
                                      if(Last_F.l(f1),
                                              b=0;
                                      );
                                      break;


                              );
                         );

*                           if (Fl=32,
*                                  display Fl,use_conec.l ;
*                           );
*                         if(use_conec.l(f2,f1),
*                           if (Fl=32,
*                                   display Fl;
*                           );
*                           con_LOF(D,f2,f1)$(ord(D)=i)=1;
*                           LOF(D,f1)$(ord(D)=i)=1;
*                           FF(f1)=1;
*                           Fl=ord(f1);
*                           if (Fl=32,
*                                   display Fl,use_conec.l ;
*                           );
*                         );
                 );

                 break;
         );
);

display LOF, con_LOF, FF;
Scalar coste_scalar;
coste_scalar=FinalCost.l;
execute_unload 'LOF.gdx' LOF
execute_unload 'con_LOF.gdx' con_LOF
execute_unload 'coste_scalar' coste_scalar

