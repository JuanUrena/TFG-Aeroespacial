$include set.gms
$include data.gms
$include data_bandp.gms
$setglobal ide "ide=%gams.ide% lo=%gams.lo% errorlog=%gams.errorlog% errmsg=1"

Parameter used(D);


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

execute_load 'All_Duty' duties_test;
execute_load 'cost_Duty' CostOfDurty_test;


Must_use_duty(D)=0;

Can_use_duty(D)=1;

execute_unload 'Must_Duty' Must_use_duty;
execute_unload 'Can_Duty' Can_use_duty;

d_aux=0;

*LOFs de la sol. incumbente
Duties_incum(D)=0;

*Coste óptimo del padre del nodo
Cost_Parent(N)=0;
*LOFs de la solución del nodo
Node(N,D)=0;

*Nodos accedidos
iter_n=0;
*Nodos generados, siempre tenemos la raíz generada sin restricciones. El problema general
gen_n=1;

just_test=1;

*Coste del nodo resulto
Cost_node=0;
*Coste incumbente
sol_incum=0;

end=0;
repeat(
         iter_n=iter_n+1;
         Must_use_duty(D)=0;
         Can_use_duty(D)=1;

*Si vengo de un nodo que ha quedado en peor posicion que la incumbente no lo investigo más
         loop((n2)$(ord(n2)=iter_n),
                 if( ( ( ( Cost_Parent(n2) ) < sol_incum ) or (not (sol_incum)) ) ,
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

* Clásico
*                 execute "gams col_gen_separate.gms %ide%";
* Integrado
                 execute "gams master_LP.gms %ide%";

                 execute_load "All_Duty" duties_test=duties_test;
                 execute_load 'cost_Duty' CostOfDurty_test=CostOfDurty_test;
                 execute_load "Used_Duty" used=Used_duti.l;
                 execute_load "Cost_Operation" Cost_node=TotalCost.l;


                 d_aux=0;

                 which(D)=0
                 loop(D $(used(D) and used(D)<1),
                         d_aux = d_aux+1;
                         which(D)=used(D);
                 );

*Si no es una sol entera y por tanto debo seguir ramificando y quedan nodos
                 if ((gen_n<50 and d_aux and (Cost_node<sol_incum or not sol_incum)) ,

*Miro cual es el máximo de los que estan por debajo de 1
                         m=0;

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

                         loop(D $(used(D) and used(D)=m),
                                 Node(N,D)$(ord(N)=gen_n+2)=+1;
                                 Node(N,D)$(ord(N)=gen_n+1)=-1;
                                 break;
                         );
                         gen_n=gen_n+2;
*Todas las soluciones son enteras y por tanto me vale
                 elseif (not d_aux),

*Compruebo si supera la incumbente;
*Almaceno el nodo y las LOFs usadas.
                         if ((Cost_node<sol_incum or (not sol_incum)),
                                 sol_incum=Cost_node;
                                 display 'Se actualiza la solución incumbente', iter_n;
                                 Duties_incum(D)=used(D);
                         );
                 );
             );
         );


until iter_n=gen_n);
execute_load 'Num_duty' d_act;

execute_unload 'Cost_solution' sol_incum;
display sol_incum, Duties_incum, d_act,Node;





