$title master

$include set.gms
$include data.gms 
$setglobal ide "ide=%gams.ide% lo=%gams.lo% errorlog=%gams.errorlog% errmsg=1"

*$include generate_duty.gms
*$include main_duty.gms
*$include main_test_duty.gms
*$include generate_duty.gms
*$include main_duty_branch_and_price.gms
*$include duality_problem.gms
*$include comb_cost_duty.gms
option optcr = 0;

*Active_duties('8')=1;
*Problema principal
Scalar Cost_operation;
Scalar Result_Select_duty;
Scalar twice;
twice=0;


*Inicialization
Scalar d_act;
execute_load 'Num_duty' d_act;
*d_act=8;
*loop (d1,
*loop (d1$D_ini(d1),
*         Selected_duty_comb(d1)=0;
*         Selected_duty_comb(d1)$(ord(d1)=d_act)=1;
*         solve comb_duty minimizing cost_combustible using MIP;
*         Cost_comb(d1)$(ord(d1)=d_act)=cost_combustible.l;
*         Selected_duty_comb(d1)$(ord(d1)=d_act)=0;
*         d_act=d_act+1;
*);
*display Cost_comb;


* Solve Main
* Selected new duty
* Look if it is less 0 and no repeated
* Solve fuel problem for the new duty
* Repeat

*CostOfDurty_test(D)=0;
*CostOfDurty_test('1')=300;
*CostOfDurty_test('2')=340;
*CostOfDurty_test('3')=335;
*CostOfDurty_test('4')=275;
*CostOfDurty_test('5')=360;
*CostOfDurty_test('6')=300;
*CostOfDurty_test('7')=340;
*CostOfDurty_test('8')=421;
*CostOfDurty_test('9')=376;
*CostOfDurty_test('10')=476;
*CostOfDurty_test('11')=461;
*duties_test(D, F)=0;
*duties_test('1','1')=1;
*duties_test('2','2')=1;
*duties_test('3','3')=1;
*duties_test('4','4')=1;
*duties_test('5','5')=1;
*duties_test('6','6')=1;
*duties_test('7','7')=1;
*duties_test('8','7')=1;
*duties_test('8','1')=1;
*duties_test('9','4')=1;
*duties_test('9','6')=1;
*duties_test('10','2')=1;
*duties_test('10','3')=1;
*duties_test('11','5')=1;
*duties_test('11','6')=1;

Scalar t;
Scalar opt;
Scalar opt2;
Scalar new_cost;
opt=0;
Parameter S(F);
S(F)=0;
Parameter used_d(D);
used_d(D)=0;
Parameter used_d_g(D);
used_d_g(D)=0;
Scalar now;
Parameter reposted_combustible(F);
repeat(
*option RMIP=CONOPT;
         execute_load 'All_Duty' duties_test;
         execute_load 'cost_Duty' CostOfDurty_test;
         execute_load 'Reposting_Duty' Fly_reposted;
         execute "gams main_duty_branch_and_price_LP.gms %ide%";
         execute_load 'Used_duty' used_d=Used_duti.l;

*         execute_load 'V_Dual_F' dual=rescover_b_and_p.m;
*         execute_load 'V_Dual_D' v_dual_d=x;

         display used_d;
*    solve main_problem_duty_and_price minimizing TotalCost using RMIP;
*Actualizo los valores duales
*         display rescover.m;
*         dual(F) = rescover.m(F);
*    loop (D$Used_duti.l(D),
*         t=0;
*         loop (F$duties_test(D,F),
*                 t=t+1;
*         );
*         loop (F$duties_test(D,F),
*            dual(F)=dual(F)+Used_duti.m(D)/t;
*         );
*    );
*     solve duality_problem maximizing dual_max using LP;
*     Cost_operation=TotalCost.l;
*         dual(F)=0;
*         v_dual_d(D)=0;

* DUALLLL
*      execute "gams duality_problem.gms %ide%";
*      execute_load 'V_Dual_F' dual=v_d.l;
*      execute_load 'V_Dual_D' v_dual_d=Dual_d;




*       execute_load 'V_Dual_F' dual=rescover_b_and_p.m;
*       execute_load 'V_Dual_D' v_dual_d=x;


*      dual(F)=  v_d.L(F);
*     v_dual_d(D)=must_duty.m(D)+can_duty.m(D)+Used_duti.m(D);
*      v_dual_d(D)=c2_d.L(D);
*     display  v_dual_d, dual;



*Calculo la nueva ruta
*    execute "gams generate_duty_DUAL.gms %ide%";
*    execute "gams generate_duty_LP.gms %ide%";
     execute "gams generate_duty_LP_separate.gms %ide%";
     execute_load 'Opt_duty' opt=z.l;
     execute_load 'Select_F' S=Selected_F.l;
     execute_load 'new_cost_Duty' new_cost=cost_duty.l;
     execute_load 'Repos_Duty' reposted_combustible=reposted_combustible.l;

     display S;
*    display Selected_F.l;
*Añado la nueva duty seleccionada

*    loop((D)$Selected_duty.l(D),
*         twice= Active_duties(D);
*    );

*    Active_duties(D)$Selected_duty.l(D)=1;

*    Selected_duty_comb(D)$Selected_duty.l(D)=1;
*    display Selected_duty_comb;
*    solve comb_duty minimizing cost_combustible using MINLP;
*    opt=0;
*     display opt;
*     opt=opt+new_cost;
*     opt=d_act-9;
     if ((opt< -0.1),
         d_act=d_act+1;
         execute_unload 'Num_duty' d_act;
*    CostOfDurty_test(D)$Selected_duty.l(D)=cost_combustible.l;
         CostOfDurty_test(D)$(ord(D)=d_act)=new_cost;
*         CostOfDurty_test(D)$(ord(D)=d_act+1)=cost_duty.l;
*     Selected_duty_comb(D)$Selected_duty.l(D)=0;
         Fly_reposted(D,F)$(ord(D)=d_act)=reposted_combustible(F);
         duties_test(D, F)$((ord(D)=d_act) and S(F)>0.9999)=1;
*         duties_test(D, F)$((ord(D)=d_act+1) and Selected_F.l(F))=0;
*         display duties_test;
*         display CostOfDurty_test;
         execute_unload 'Reposting_Duty' Fly_reposted;
         execute_unload 'cost_duty' CostOfDurty_test;
         execute_unload 'All_Duty' duties_test;
*    display Selected_duty.l;
*    Result_Select_duty = z.l;
        );

    display duties_test;

until (opt >= -0.1)
*until (d_act>9)
);

*Parameter u_d(D);
*u_d(D)=Used_duti.l(D);

*display Used_duti.l;

*START-Branch AND Price
*display u_d;
*display duties_test;
*display CostOfDurty_test;

*execute_unload 'Used_Duty' used_d=Used_duti;
*execute_unload 'All_Duty' duties_test;
*execute_unload 'Cost_Duty' CostOfDurty_test;
*execute_unload 'Cost_Operation' TotalCost;
display 'Used Duty', used_d;
*All dutys are allow
*Active_duties(D)=1;
*display Active_duties;
*Must_use_duty('1')=1;
*solve main_problem_duty_and_price minimizing TotalCost using RMIP;
*Must_use_duty('1')=0;
*Can_use_duty('1')=0;
*solve main_problem_duty_and_price minimizing TotalCost using RMIP;
*display Used_duti.l;
