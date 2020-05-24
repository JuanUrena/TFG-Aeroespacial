*$include set.gms


Parameter CostOfDurty(D);


Parameter dual(F);



Parameter Flight(F, c1, c2, t1, t2);
Flight(F, c1, c2, t1, t2)=0;
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

*Dutis de 1 F

Parameter duties(D, F);
duties(D, F)=0;

Parameter time_stop(D);
time_stop(D)=1000000;



* Genero Duty de 1, 2, 3 vuelos, sus costes y sus tiempos en tierra
Scalar i;
i=1;
*loop((F, c1, c2, t1, t2)$Flight(F, c1, c2, t1, t2),
*         time_stop(D)$(ord(D)=i)=(1440-ord(t2))+(ord(t1)-1);
*         duties(D,F)$(ord(D)=i)=1;
*         CostOfDurty(D)$(ord(D)=i)=1;
*         i=i+1;
*);

*loop((f1,c1,c2,t1,t2)$Flight(f1, c1, c2, t1, t2),
*         loop((f2, c3, t3 ,t4)$( Flight(f2, c2, c3, t3, t4) and ( ord(t3) > ord(t2) ) ),
*                 time_stop(D)$(ord(D)=i)=(1440-ord(t4))+(ord(t1)-1)+(ord(t3)-ord(t2));
*                 duties(D,f1)$(ord(D)=i)=1;
*                 duties(D,f2)$(ord(D)=i)=1;
*                 CostOfDurty(D)$(ord(D)=i)=2;
*                 i=i+1;
*         )
*);
*loop((f1,c1,c2,t1,t2)$Flight(f1, c1, c2, t1, t2),
*         loop((f2, c3, t3 ,t4)$( Flight(f2, c2, c3, t3, t4) and ( ord(t3) > ord(t2) ) ),
*                 loop((f3, c4, t5 ,t6)$( Flight(f3, c3, c4, t5, t6) and ( ord(t5) > ord(t4) ) ),
*                         time_stop(D)$(ord(D)=i)=(1440-ord(t6))+(ord(t1)-1)+(ord(t3)-ord(t2))+(ord(t5)-ord(t4));
*                         duties(D,f1)$(ord(D)=i)=1;
*                         duties(D,f2)$(ord(D)=i)=1;
*                         duties(D,f3)$(ord(D)=i)=1;
*                         CostOfDurty(D)$(ord(D)=i)=3;
*                         i=i+1;
*                 )
*         )
*);

*CostOfDurty('10')=0;
*display time_stop;


* Combustible consumido entre ciudades
Parameter consum_comb(c1, c2);
*execute_load "dij" consum_comb=d;
*display d;

* Precio de comb en cada ciudad
Parameter Price_comb(C);

consum_comb(c1, c2)=0;
consum_comb('A', 'B')=100;
consum_comb('A', 'C')=50;
consum_comb('A', 'D')=80;
consum_comb('A', 'E')=70;
consum_comb('A', 'F')=85;

consum_comb('B', 'A')=100;
consum_comb('B', 'C')=70;
consum_comb('B', 'D')=30;
consum_comb('B', 'E')=65;
consum_comb('B', 'F')=75;


consum_comb('C', 'A')=50;
consum_comb('C', 'B')=70;
consum_comb('C', 'D')=90;
consum_comb('C', 'E')=65;
consum_comb('C', 'F')=75;

consum_comb('D', 'A')=80;
consum_comb('D', 'B')=30;
consum_comb('D', 'C')=90;
consum_comb('D', 'E')=110;
consum_comb('D', 'F')=120;

consum_comb('E', 'A')=70;
consum_comb('E', 'B')=65;
consum_comb('E', 'C')=65;
consum_comb('E', 'D')=110;
consum_comb('E', 'F')=35;

consum_comb('F', 'A')=85;
consum_comb('F', 'B')=75;
consum_comb('F', 'C')=75;
consum_comb('F', 'D')=120;
consum_comb('F', 'E')=35;

* Precio de comb en cada ciudad
Price_comb('A')=1;
Price_comb('B')=2;
Price_comb('C')=1.5;
Price_comb('D')=2;
Price_comb('E')=2;
Price_comb('F')=1.75;


*  Indica para que Duty hay que calcular el min coste de comb
Parameter Selected_duty_comb(D);
Selected_duty_comb(D)=0;
*Selected_duty_comb('14')=1;
*Selected_duty_comb('10')=1;


*Para obligar a que use una duty; 1-Sí; 0-No
Parameter Must_use_duty(D);
Must_use_duty(D)=0;
Must_use_duty('1')=1;

*Para obligar a que no use una duty; 1-Sí; 0-No
Parameter Can_use_duty(D);
Can_use_duty(D)=1;
*Can_use_duty('8')=0;
*display duties,time_stop ;


* Coste minimo del comb necesario para operar una Duty
Parameter Cost_comb(D);
Cost_comb(D)=1000000000;

Parameter oa(f,c1),da(f,c1),ot(f,t1), dt(f,t1), dur(f) programa de vuelos por salidas-llegadas-horas;

*loop((f,c1,c2,t1,t2)$Flight(f,c1,c2,t1,t2),
*aeropuerto de salida de f
*oa(f,c1)=  1;
*aeropuerto de llegada de f
*da(f,c2)= 1;
*hora de salida de f
*ot(f,t1)= 1;
*hora de llegada de f
*dt(f,t2)=1;
*dur(f)=(ord(t2)-ord(t1));
*);

Parameter connec(f,f) parametro de conectividad de vuelos;
Parameter cost_connec(f,f) coste de la conex
*loop((f1,f2,c1)$(oa(f2,c1) and da(f1,c1)),
*primer bucle para comprobar compatibilidad de vuelos, aeropuerto de llegada de f y salida de ff
*         loop((t1,t2)$(ot(f2,t2) and dt(f1,t1) and ord(t2) ge ord(t1) and ord(t2) le (ord(t1)+840)),
*segundo bucle para comprobar la compatibilidad horaria: salida de ff mas tarde que llegada de f, pero con maximo de 14 horas (840min) de conexion
*                 connec(f1,f2)=1;
*                 cost_connec(f1,f2)=max( 400*(120-(ord(t2)-ord(t1))), 1);
*         );
*);

*display ot, dt, connec;

Parameter duties_test(D,F);
*duties_test(D,F)= 0;
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
*duties_test('10','4')=1;
*duties_test('10','6')=1;


Parameter CostOfDurty_test(D);
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
*CostOfDurty_test('10')=375;

*display  CostOfDurty_test;

*execute_load "Cost_Duty" CostOfDurty_test=master_Cost;
*execute_load"All_Duty" duties_test=master_D;
*execute_unload 'cost_duty' CostOfDurty_test;
*execute_unload 'duty' duties_test;

*execute_load 'duty' duties_test;
Parameter Dual_d(D);
Dual_d(D)=0;
*Dual_d('8')=219;
Parameter v_dual_d(D);
 v_dual_d(D)=0;
*v_dual_d('6')=199;
*v_dual_d('8')=-219;
*v_dual_d('9')=-199;


Parameter connec_test(f1,F,D);
connec_test(f1,F,D)=0;

Parameter Fly_reposted(D,F);
Fly_reposted(D,F)=0;
