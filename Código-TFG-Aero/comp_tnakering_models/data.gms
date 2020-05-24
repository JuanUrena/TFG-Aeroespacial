* Número de rutas que quieres enrutar

Scalar d_route;
d_route=55;

Parameter Flight(F, c1, c2, t1, t2);
Flight(F, c1, c2, t1, t2)=0;
Flight(F, c1, c2, t1, t2)=0;
Flight('1', 'A', 'B', '480', '540')=1;
Flight('2', 'B', 'C', '600', '660')=1;
Flight('3', 'C', 'D', '780', '840')=1;
Flight('4', 'C', 'A', '420', '480')=1;
Flight('5', 'D', 'A', '420', '480')=1;
Flight('6', 'A', 'B', '1020', '1080')=1;
Flight('7', 'B', 'C', '660', '720')=1;
Flight('8', 'A', 'C', '840', '900')=1;
Flight('9', 'A', 'C', '960', '1020')=1;
Flight('10', 'B', 'D', '420', '540')=1;
Flight('11', 'B', 'A', '780', '840')=1;
Flight('12', 'D', 'A', '660', '720')=1;
Flight('13', 'D', 'C', '1020', '1080')=1;
Flight('14', 'C', 'A', '960', '1020')=1;
Flight('15', 'C', 'B', '840', '930')=1;
Flight('16', 'A', 'D', '630', '690')=1;
Flight('17', 'A', 'D', '1020', '1080')=1;
Flight('18', 'C', 'A', '1340', '1400')=1;
Flight('19', 'D', 'A', '1260', '1320')=1;
Flight('20', 'C', 'A', '1240', '1300')=1;

Flight('21', 'E', 'B', '480', '540')=1;
Flight('22', 'F', 'C', '600', '660')=1;
Flight('23', 'C', 'E', '780', '840')=1;
Flight('24', 'F', 'A', '420', '480')=1;
Flight('25', 'D', 'F', '420', '480')=1;
Flight('26', 'A', 'F', '1020', '1080')=1;
Flight('27', 'B', 'E', '660', '720')=1;
Flight('28', 'A', 'E', '840', '900')=1;
Flight('29', 'A', 'F', '960', '1020')=1;
Flight('30', 'F', 'D', '420', '540')=1;
Flight('31', 'F', 'A', '780', '840')=1;
Flight('32', 'E', 'A', '660', '720')=1;
Flight('33', 'E', 'F', '1020', '1080')=1;
Flight('34', 'C', 'F', '960', '1020')=1;
Flight('35', 'C', 'A', '840', '930')=1;
Flight('36', 'F', 'D', '630', '690')=1;
Flight('37', 'F', 'E', '1020', '1080')=1;
Flight('38', 'F', 'A', '1340', '1400')=1;
Flight('39', 'C', 'A', '1260', '1320')=1;
Flight('40', 'F', 'A', '1240', '1300')=1;

Parameter duties(D, F);
duties(D, F)=0;

Parameter connec(D, f1, f2);
connec(D, f1, f2)=0;

Scalar i;
i=1;


scalar starttime;
starttime = jnow;

* 1 Vuelo
*loop((F, c1, c2, t1, t2)$Flight(F, c1, c2, t1, t2),
*         if( i=15,
*         time_stop(D)$(ord(D)=i)=(1440-ord(t2))+(ord(t1)-1);
*         duties(D,F)$(ord(D)=i)=1;
*         );
*         i=i+1;

*);


* 2 Vuelos
loop((f1,c1,c2,t1,t2)$Flight(f1, c1, c2, t1, t2),
         loop((f2, c3, t3 ,t4)$( Flight(f2, c2, c3, t3, t4) and ( ord(t3) > ord(t2) ) ),
                 if (i <= d_route,
                    duties(D,f1)$(ord(D)=i)=1;
                    duties(D,f2)$(ord(D)=i)=1;
                    connec(D,f1,f2)$(ord(D)=i)=1;
                    i=i+1;
                 )
         )
);

* 3 Vuelos
loop((f1,c1,c2,t1,t2)$Flight(f1, c1, c2, t1, t2),
         loop((f2, c3, t3 ,t4)$( Flight(f2, c2, c3, t3, t4) and ( ord(t3) > ord(t2) ) ),
                 loop((f3, c4, t5 ,t6)$( Flight(f3, c3, c4, t5, t6) and ( ord(t5) > ord(t4) ) ),
                         if (i <= d_route,
                             duties(D,f1)$(ord(D)=i)=1;
                             duties(D,f2)$(ord(D)=i)=1;
                             duties(D,f3)$(ord(D)=i)=1;
                             connec(D,f1,f2)$(ord(D)=i)=1;
                             connec(D,f2,f3)$(ord(D)=i)=1;
                             i=i+1;
                         );
                 )
         )
);


* 4 Vuelos
*loop((f1,c1,c2,t1,t2)$Flight(f1, c1, c2, t1, t2),
*         loop((f2, c3, t3 ,t4)$( Flight(f2, c2, c3, t3, t4) and ( ord(t3) > ord(t2) ) ),
*                 loop((f3, c4, t5 ,t6)$( Flight(f3, c3, c4, t5, t6) and ( ord(t5) > ord(t4) ) ),
*                         loop((f4, c5, t7 ,t8)$( Flight(f4, c4, c5, t7, t8) and ( ord(t7) > ord(t6) ) ),
*                 if( i=15,
*                         duties(D,f1)$(ord(D)=i)=1;
*                         duties(D,f2)$(ord(D)=i)=1;
*                         duties(D,f3)$(ord(D)=i)=1;
*                         duties(D,f4)$(ord(D)=i)=1;
*                         connec(D,f1,f2)$(ord(D)=i)=1;
*                         connec(D,f2,f3)$(ord(D)=i)=1;
*                         connec(D,f3,f4)$(ord(D)=i)=1;
*                 );
*                         i=i+1;
*                         )
*                 )
*         )
*);


display i;

scalar elapsed;
elapsed = (jnow - starttime)*24*3600;
display elapsed;

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

Parameter  Selected_duty_comb(D);
Selected_duty_comb(D)=0;
Selected_duty_comb('8')=1;

display duties;
