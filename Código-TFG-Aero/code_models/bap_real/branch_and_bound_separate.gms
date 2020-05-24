$title master

$include set.gms
$include data.gms
$setglobal ide "ide=%gams.ide% lo=%gams.lo% errorlog=%gams.errorlog% errmsg=1"

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
         execute_load 'All_Duty' duties_test;
         execute_load 'cost_Duty' CostOfDurty_test;
         execute_load 'Reposting_Duty' Fly_reposted;
         execute "gams master_bab.gms %ide%";
         execute_load 'Used_duty' used_d=Used_duti.l;



         display used_d;


*Calculo la nueva ruta

     execute "gams slave_separate.gms %ide%";
     execute_load 'Opt_duty' opt=z.l;
     execute_load 'Select_F' S=Selected_F.l;
     execute_load 'new_cost_Duty' new_cost=cost_duty.l;
     execute_load 'Repos_Duty' reposted_combustible=reposted_combustible.l;

     display S;

     if ((opt< 0),
         d_act=d_act+1;
         execute_unload 'Num_duty' d_act;
         CostOfDurty_test(D)$(ord(D)=d_act)=new_cost;
         Fly_reposted(D,F)$(ord(D)=d_act)=reposted_combustible(F);
         duties_test(D, F)$((ord(D)=d_act) and S(F)>0.9999)=1;
         execute_unload 'Reposting_Duty' Fly_reposted;
         execute_unload 'cost_duty' CostOfDurty_test;
         execute_unload 'All_Duty' duties_test;
        );

    display duties_test;

until (opt >= 0)

);


display 'Used Duty', used_d;

