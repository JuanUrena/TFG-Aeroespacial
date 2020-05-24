Parameter Departure(F,C);
Departure(F,C)=0;

Departure('1','A')=1;
Departure('2','B')=1;
Departure('3','C')=1;
Departure('4','C')=1;
Departure('5','D')=1;
Departure('6','A')=1;
Departure('7','B')=1;

Parameter Arrive(F,C);
Arrive(F,C)=0;

Arrive('1','B')=1;
Arrive('2','C')=1;
Arrive('3','D')=1;
Arrive('4','A')=1;
Arrive('5','A')=1;
Arrive('6','B')=1;
Arrive('7','C')=1;

Parameter Departure_time(F,time);
Departure(F,C)=0;

Departure('1','A')=1;
Departure('2','B')=1;
Departure('3','C')=1;
Departure('4','C')=1;
Departure('5','D')=1;
Departure('6','A')=1;
Departure('7','B')=1;

Parameter Arrive_time(F,time);
Arrive(F,C)=0;

Arrive('1','B')=1;
Arrive('2','C')=1;
Arrive('3','D')=1;
Arrive('4','A')=1;
Arrive('5','A')=1;
Arrive('6','B')=1;
Arrive('7','C')=1;

Parameter FinDuty(F,D);
FinDuty(F,D)=0;

FinDuty('1','1')=1;
FinDuty('4','2')=1;
FinDuty('5','3')=1;
FinDuty('6','4')=1;
FinDuty('7','5')=1;
FinDuty('1','6')=1;
FinDuty('2','6')=1;
FinDuty('1','7')=1;
FinDuty('7','7')=1;
FinDuty('3','7')=1;
FinDuty('2','8')=1;
FinDuty('3','8')=1;

Parameter CostOfDurty(D);
CostOfDurty(D)=1000000;
CostOfDurty('1')=1;
CostOfDurty('2')=1;
CostOfDurty('3')=1;
CostOfDurty('4')=1;
CostOfDurty('5')=1;
CostOfDurty('6')=1;
CostOfDurty('8')=1;
CostOfDurty('7')=1;

Parameter DutyinPairing(D, P);
DutyinPairing(D, P)=0;
DutyinPairing('6', '1')=1;
DutyinPairing('2', '1')=1;
DutyinPairing('7', '2')=1;
DutyinPairing('3', '2')=1;
DutyinPairing('4', '3')=1;
DutyinPairing('8', '3')=1;
DutyinPairing('3', '3')=1;
DutyinPairing('4', '4')=1;
DutyinPairing('5', '4')=1;
DutyinPairing('2', '4')=1;
DutyinPairing('1', '5')=1;
DutyinPairing('5', '5')=1;
DutyinPairing('2', '5')=1;

Parameter CostOfPairing(P);
CostOfPairing(P)=10000000;
CostOfPairing('1')=1;
CostOfPairing('2')=0;
CostOfPairing('3')=0;
CostOfPairing('4')=1;
CostOfPairing('5')=2;



Parameter dual(F);
dual(F)=0;
dual('1')=300;
dual('2')=340;
dual('3')=335;
dual('4')=275;
dual('5')=360;
dual('6')=300;
dual('7')=340;



Parameter Flight(F, c1, c2, t1, t2);
Flight(F, c1, c2, t1, t2)=0;


Parameter duties(D, F);
duties(D, F)=0;

Parameter time_stop(D);
time_stop(D)=1000000;



Scalar i;
i=1;


* Combustible consumido entre ciudades
Parameter consum_comb(c1, c2);
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
Parameter Price_comb(C);
Price_comb('A')=1;
Price_comb('B')=2;
Price_comb('C')=1.5;
Price_comb('D')=2;
Price_comb('E')=2;
Price_comb('F')=1.75;


Parameter Selected_duty_comb(D);
Selected_duty_comb(D)=0;

* Indica que Duty estan activas en el main
Parameter Active_duties(D);
Active_duties(D)=0;
Active_duties(D_ini)=1;

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


Parameter connec(f,f) parametro de conectividad de vuelos;
Parameter cost_connec(f,f) coste de la conex


*display ot, dt, connec;

Parameter duties_test(D,F);
Parameter CostOfDurty_test(D);

Parameter Dual_d(D);
Dual_d(D)=0;
Parameter v_dual_d(D);
 v_dual_d(D)=0;


Parameter connec_test(f1,F,D);
connec_test(f1,F,D)=0;

Parameter Fly_reposted(D,F);
Fly_reposted(D,F)=0;
