Parameter Flight_All(F, c1, c2, t1, t2);

Flight(F, c1, c2, t1, t2)=0;
execute_load 'Flight' Flight;

*Parameter CostOfDurty_test(D);
CostOfDurty_test(D)=0;

*Parameter duties_test(D,F);
duties_test(D,F)=0;
Scalar d_act;
d_act=0;

* Creo LOFs para cada vuelo
Fly_reposted(D,F)=0;
loop((F,c1,c2,t1,t2)$Flight(F, c1, c2, t1, t2),
         d_act=d_act+1;
         CostOfDurty_test(D)$(ord(D)=d_act)=600+Price_comb(c1)*consum_comb(c1,c2);
         if (not(Base(c1)),
                 CostOfDurty_test(D)$(ord(D)=d_act)=CostOfDurty_test(D)$(ord(D)=d_act)+20;
         );
         if (not(Base(c2)),
                 CostOfDurty_test(D)$(ord(D)=d_act)=CostOfDurty_test(D)$(ord(D)=d_act)+50;
         );
         Fly_reposted(D,F)$(ord(D)=d_act)=consum_comb(c1,c2);
         duties_test(D,F)$(ord(D)=d_act)=1;
);

execute_unload 'Num_duty' d_act;


loop((f,c1,c2,t1,t2)$Flight(f,c1,c2,t1,t2),
*aeropuerto de salida de f
oa(f,c1)=  1;
*aeropuerto de llegada de f
da(f,c2)= 1;
*hora de salida de f
ot(f,t1)= 1;
*hora de llegada de f
dt(f,t2)=1;
dur(f)=(ord(t2)-ord(t1));
);

connec(f1,f2)=0;
cost_connec(f1,f2)=0;
* Vuelos que se pueden conectar y su coste

loop((f1,f2,c1)$(oa(f2,c1) and da(f1,c1)),
*primer bucle para comprobar compatibilidad de vuelos, aeropuerto de llegada de f y salida de ff
         loop((t1,t2)$(ot(f2,t2) and dt(f1,t1) and ord(t2) ge ord(t1)),
*segundo bucle para comprobar la compatibilidad horaria: salida de ff mas tarde que llegada de f, pero con maximo de 14 horas (840min) de conexion
                 connec(f1,f2)=1;
                 cost_connec(f1,f2)=max(400*(120-(ord(t2)-ord(t1))), 0);
         );
);

execute_unload 'Reposting_Duty' Fly_reposted;
execute_unload 'All_Duty' duties_test;
execute_unload 'cost_Duty' CostOfDurty_test;
execute_unload 'cost_connec' cost_connec;
execute_unload 'connec' connec;

