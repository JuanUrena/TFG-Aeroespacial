$include set.gms
$include data.gms
$include data_master.gms
$setglobal ide "ide=%gams.ide% lo=%gams.lo% errorlog=%gams.errorlog% errmsg=1"

Parameter used(D);

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


Scalar sol_incum;
Scalar loop_i;
Scalar end;
Parameter Must_use_duty(D);
Parameter Can_use_duty(D);
Scalar d_aux;
Parameter which(D);
Parameter Duties_incum(D);
Parameter Cost_Parent(N);
Parameter Node(N, D);
Scalar iter_n;
Scalar d_act;
Scalar gen_n;
Scalar just_test;
Scalar m;
Scalar Cost_node;
Parameter sol(N);
Parameter sol_inc(N);

*Scalar num_F;
*num_F=17;

*execute_unload 'Actual_num_F' num_F;
*execute_unload 'Flight' Flight;

*loop ((F,c1,c2,t1,t2)$(Flight_All(F, c1, c2, t1, t2) and ord(F)<num_F),
*         Flight(F, c1, c2, t1, t2)=1
*);

execute_load 'All_Duty' duties_test;
execute_load 'cost_Duty' CostOfDurty_test;


*execute "gams master.gms %ide%";

*$gdxin Used_Duty.gdx
*$load used=u_d
*$gdxin

*$gdxin All_Duty.gdx
*$load master_D=duties_test
*$gdxin

*$gdxin Cost_Duty.gdx
*$load used=CostOfDurty_test
*$gdxin



*execute_load "Used_Duty" used=u_d;
*execute_load "All_Duty" master_D=duties_test;
*execute_load "Cost_Duty" master_Cost=CostOfDurty_test;
*display used;
*display master_D;
*display master_Cost;


Must_use_duty(D)=0;

Can_use_duty(D)=1;

execute_unload 'Must_Duty' Must_use_duty;
execute_unload 'Can_Duty' Can_use_duty;

*Scalar d_act;
*d_act=7;
*execute_unload 'Num_duty' d_act;



d_aux=0;


Duties_incum(D)=0;


Cost_Parent(N)=0;

Node(N,D)=0;

sol(N)=0;
sol_inc(N)=0;




iter_n=0;

gen_n=1;

just_test=1;

Cost_node=0;


sol_incum=0;

end=0;
*Alguno es menor que 1 y mayor que cero, por ende no es entero y hay que hacer B&P
*if (d_aux,
*         display d_aux;
*         m=smax(D,which(D));
*         loop(D $(used(D) and used(D)=m),
*         loop(D$(ord(D)=just_test),
*         display m;
*         Active(N)$(ord(N)=iter_n*2)=1;
*         Active(N)$(ord(N)=iter_n*2+1)=1;
*         Node(N,D)$(ord(N)=iter_n*2)=1;
*         Node(N,D)$(ord(N)=iter_n*2+1)=-1;
*         );
*         just_test=just_test+1;
* Sacamos la Duty con el max valor por debajo de 1;

*Fijamos a 1 con Must use y recalculamos, y empezamos el modelo iterativo con un B&P
*         Must_use_duty(D)=0;
*         Can_use_duty(D)=0;
         repeat (
                 iter_n=iter_n+1;
                 Must_use_duty(D)=0;
                 Can_use_duty(D)=1;
*         just_test=just_test+1;
*         end=end+1;
*         for (loop_i=1 to 2**end by 1,

*Si vengo de un nodo que ha quedado en peor posicion que la incumbente no lo investigo más
             loop((N22)$(ord(N22)=iter_n),
              if( ( ( ( Cost_Parent(N22) ) < sol_incum ) or (not (sol_incum)) ) ,
                 display 'Accede al nodo', iter_n;
                 loop ((D,N)$(ord(N)=iter_n),
                      if (Node(N,D)>0,
                         Must_use_duty(D)=1;
                      elseif (Node(N,D)<0),
                          Can_use_duty(D)=0;
                       );
                 );

                 execute_unload 'Must_Duty' Must_use_duty;
                 execute_unload 'Can_Duty' Can_use_duty;
*                 execute_unload "All_Duty" duties_test;
*                 execute_unload "cost_Duty" CostOfDurty_test;

                 execute "gams master_LP_separate.gms %ide%";
*                 execute "gams master.gms %ide%";
                 execute_load "All_Duty" duties_test=duties_test;
                 execute_load 'cost_Duty' CostOfDurty_test=CostOfDurty_test;
                 execute_load "Used_Duty" used=Used_duti.l;
                 execute_load "Cost_Operation" Cost_node=TotalCost.l;

                 display Cost_node;
                 sol(N)$(ord(N)=iter_n)=Cost_node;
*                 display iter_n,Cost_node, used,duties_test ;

*                 loop (N$(Active(N)and(ord(N)=iter_n)),
*                         loop(D,
*                                 if (Node(N,D)>0,
*                                         Must_use_duty(D)=1;
*                                 elseif (Node(N,D)<0),
*                                         Can_use_duty(D)=0;
*                                 );
*                         );
*                 );

                 d_aux=0;
*                 if (iter_n=1,
*                     used('1')=0.5;
*                 );
                 which(D)=0
                 loop(D $(used(D) and used(D)<1),
                         d_aux = d_aux+1;
                         which(D)=used(D);
                 );
*                 display iter_n, d_aux;
*                 display which, used;
*Si no es una sol entera y por tanto debo seguir ramificando y quedan nodos
                 if ((gen_n<100 and d_aux and (Cost_node<sol_incum or not sol_incum)) ,

*Miro cual es el máximo de los que estan por debajo de 1
                         m=0;
*                         display which;
                         m=smax(D,which(D));

*Le suma mis condiciones
                         loop((N,D)$(Node(N,D)and(ord(N)=iter_n)),
                                 loop(n1,
                                         Node(n1,D)$(ord(n1)=gen_n+1)=Node(N,D);
                                         Node(n1,D)$(ord(n1)=gen_n+2)=Node(N,D);
                                 );
                         );
                         Cost_Parent(N)$(ord(N)=gen_n+1)=Cost_node;
                         Cost_Parent(N)$(ord(N)=gen_n+2)=Cost_node;
*Añade la siguiente var a ramificar
*                         display iter_n, m;
                         loop(D $(used(D) and used(D)=m),
*                          loop(D$(ord(D)=just_test),
*                                 Active(N)$(ord(N)=gen_n)=1;
*                                 Active(N)$(ord(N)=gen_n+1)=1;
                                 Node(N,D)$(ord(N)=gen_n+2)=+1;
                                 Node(N,D)$(ord(N)=gen_n+1)=-1;
*                                 display Node;
                                 break;
                         );
                         gen_n=gen_n+2;
*Todas las soluciones son enteras y por tanto me vale
                 elseif (not d_aux),

*Compruebo si supera la incumbente;
*Almaceno el nodo y las dutis usadas.
                         if ((Cost_node<sol_incum or (not sol_incum)),
                                 sol_incum=Cost_node;
                                 display 'Se actualiza la solución incumbente', iter_n;
                                 Duties_incum(D)=used(D);
                         );
                 );
                 sol_inc(N)$(ord(N)=iter_n)=sol_incum;
*Avanzo nodo
             );
         );


         until iter_n=gen_n);
         execute_load 'Num_duty' d_act;

*  display Must_use_duty;
*);
*display iter_n;
execute_unload 'Cost_solution' sol_incum;
display sol_incum, Duties_incum, d_act,Node, sol_inc, sol;

execute 'gdxxrw.exe All_Duty.gdx o=All_Duty.xls par=duties_test'
execute 'gdxxrw.exe cost_Duty.gdx o=cost_Duty.xls par=CostOfDurty_test'




