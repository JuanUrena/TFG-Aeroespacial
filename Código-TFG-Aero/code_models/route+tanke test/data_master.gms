*$include set.gms
*$include data.gms


Parameter Flight_All(F, c1, c2, t1, t2);

Flight(F, c1, c2, t1, t2)=0;
*Parameter Flight(F, c1, c2, t1, t2);
*Flight(F, c1, c2, t1, t2)=0;
*Flight('1', 'A', 'B', '480', '540')=1;
*Flight('2', 'B', 'C', '600', '660')=1;
*Flight('3', 'C', 'D', '780', '840')=1;
*Flight('4', 'C', 'A', '420', '480')=1;
*Flight('5', 'D', 'A', '420', '480')=1;
*Flight('6', 'A', 'B', '1020', '1080')=1;
*Flight('7', 'B', 'C', '660', '720')=1;
*Flight('8', 'A', 'C', '840', '900')=1;
*Flight('9', 'A', 'C', '960', '1020')=1;
*Flight('10', 'B', 'D', '420', '540')=1;
*Flight('11', 'B', 'A', '780', '840')=1;
*Flight('12', 'D', 'A', '660', '720')=1;
*Flight('13', 'D', 'C', '1020', '1080')=1;
*Flight('14', 'C', 'A', '960', '1020')=1;
*Flight('15', 'C', 'B', '840', '930')=1;
*Flight('16', 'A', 'D', '630', '690')=1;
*Flight('17', 'A', 'D', '1020', '1080')=1;
*Flight('18', 'C', 'A', '1340', '1400')=1;
*Flight('19', 'D', 'A', '1260', '1320')=1;
*Flight('20', 'C', 'A', '1240', '1300')=1;

Flight(F, c1, c2, t1, t2)=0;
execute_load 'Flight' Flight;

*Parameter CostOfDurty_test(D);
CostOfDurty_test(D)=0;

*Parameter duties_test(D,F);
duties_test(D,F)=0;
Scalar d_act;
d_act=0;


Fly_reposted(D,F)=0;
loop((F,c1,c2,t1,t2)$Flight(F, c1, c2, t1, t2),
         d_act=d_act+1;
         CostOfDurty_test(D)$(ord(D)=d_act)=30000+Price_comb(c1)*consum_comb(c1,c2);
         if (not(Base(c1)),
                 CostOfDurty_test(D)$(ord(D)=d_act)=CostOfDurty_test(D)$(ord(D)=d_act)+1000;
         );
         if (not(Base(c2)),
                 CostOfDurty_test(D)$(ord(D)=d_act)=CostOfDurty_test(D)$(ord(D)=d_act)+5000;
         );
         Fly_reposted(D,F)$(ord(D)=d_act)=consum_comb(c1,c2);
         duties_test(D,F)$(ord(D)=d_act)=1;
);

execute_unload 'Num_duty' d_act;

*Parameter oa(f,c1),da(f,c1),ot(f,t1), dt(f,t1), dur(f) programa de vuelos por salidas-llegadas-horas;

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
*display duties_test,CostOfDurty_test, Fly_reposted ;
