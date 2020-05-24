$include set.gms






$call gdxxrw.exe vuelos_alat.xlsx par=vuelos rng=A2:E101 rdim=5
*$call gdxxrw.exe vuelos_hubs.xlsx par=vuelos rng=A2:E101 rdim=5
Parameter flight(f, c1, c2, t1, t2);
execute_load "vuelos_alat" flight=vuelos;
*execute_load "vuelos_hubs" flight=vuelos;

flight(F, c1, c2, t1, t2)=0;
*Parameter Flight(F, c1, c2, t1, t2);
flight(F, c1, c2, t1, t2)=0;
flight('1', 'A', 'B', '480', '540')=1;
flight('2', 'B', 'C', '600', '660')=1;
flight('3', 'C', 'D', '780', '840')=1;
flight('4', 'C', 'A', '420', '480')=1;
flight('5', 'D', 'A', '420', '480')=1;
flight('6', 'A', 'B', '1020', '1080')=1;
flight('7', 'B', 'C', '660', '720')=1;
flight('8', 'A', 'C', '840', '900')=1;
flight('9', 'A', 'C', '960', '1020')=1;
flight('10', 'B', 'D', '420', '540')=1;
flight('11', 'B', 'A', '780', '840')=1;
flight('12', 'D', 'A', '660', '720')=1;
flight('13', 'D', 'C', '1020', '1080')=1;
flight('14', 'C', 'A', '960', '1020')=1;
flight('15', 'C', 'B', '840', '930')=1;
flight('16', 'A', 'D', '630', '690')=1;
flight('17', 'A', 'D', '1020', '1080')=1;
flight('18', 'C', 'A', '1340', '1400')=1;
flight('19', 'D', 'A', '1260', '1320')=1;
flight('20', 'C', 'A', '1240', '1300')=1;

flight('21', 'E', 'B', '480', '540')=1;
flight('22', 'F', 'C', '600', '660')=1;
flight('23', 'C', 'E', '780', '840')=1;
flight('24', 'F', 'A', '420', '480')=1;
flight('25', 'D', 'F', '420', '480')=1;
flight('26', 'A', 'F', '1020', '1080')=1;
flight('27', 'B', 'E', '660', '720')=1;
flight('28', 'A', 'E', '840', '900')=1;
flight('29', 'A', 'F', '960', '1020')=1;
flight('30', 'F', 'D', '420', '540')=1;
flight('31', 'F', 'A', '780', '840')=1;
flight('32', 'E', 'A', '660', '720')=1;
flight('33', 'E', 'F', '1020', '1080')=1;
flight('34', 'C', 'F', '960', '1020')=1;
flight('35', 'C', 'A', '840', '930')=1;
flight('36', 'F', 'D', '630', '690')=1;
flight('37', 'F', 'E', '1020', '1080')=1;
flight('38', 'F', 'A', '1340', '1400')=1;
flight('39', 'C', 'A', '1260', '1320')=1;
flight('40', 'F', 'A', '1240', '1300')=1;



execute_unload "Flight" flight;

*$call gdxxrw.exe dij.xlsx par=d rng=A2:C257 rdim=2
*Parameter d(a, a1);
*execute_load "dij" d;

*display flight, d;
