Parameter Flight_All(F, c1, c2, t1, t2);

Flight_All(F, c1, c2, t1, t2)=0;
*Parameter Flight(F, c1, c2, t1, t2);
Flight_All(F, c1, c2, t1, t2)=0;
Flight_All('1', 'A', 'B', '480', '540')=1;
Flight_All('2', 'B', 'C', '600', '660')=1;
Flight_All('3', 'C', 'D', '780', '840')=1;
Flight_All('4', 'C', 'A', '420', '480')=1;
Flight_All('5', 'D', 'A', '420', '480')=1;
Flight_All('6', 'A', 'B', '1020', '1080')=1;
Flight_All('7', 'B', 'C', '660', '720')=1;
Flight_All('8', 'A', 'C', '840', '900')=1;
Flight_All('9', 'A', 'C', '960', '1020')=1;
Flight_All('10', 'B', 'D', '420', '540')=1;
Flight_All('11', 'B', 'A', '780', '840')=1;
Flight_All('12', 'D', 'A', '660', '720')=1;
Flight_All('13', 'D', 'C', '1020', '1080')=1;
Flight_All('14', 'C', 'A', '960', '1020')=1;
Flight_All('15', 'C', 'B', '840', '930')=1;
Flight_All('16', 'A', 'D', '630', '690')=1;
Flight_All('17', 'A', 'D', '1020', '1080')=1;
Flight_All('18', 'C', 'A', '1340', '1400')=1;
Flight_All('19', 'D', 'A', '1260', '1320')=1;
Flight_All('20', 'C', 'A', '1240', '1300')=1;

Flight_All('21', 'E', 'B', '480', '540')=1;
Flight_All('22', 'F', 'C', '600', '660')=1;
Flight_All('23', 'C', 'E', '780', '840')=1;
Flight_All('24', 'F', 'A', '420', '480')=1;
Flight_All('25', 'D', 'F', '420', '480')=1;
Flight_All('26', 'A', 'F', '1020', '1080')=1;
Flight_All('27', 'B', 'E', '660', '720')=1;
Flight_All('28', 'A', 'E', '840', '900')=1;
Flight_All('29', 'A', 'F', '960', '1020')=1;
Flight_All('30', 'F', 'D', '420', '540')=1;
Flight_All('31', 'F', 'A', '780', '840')=1;
Flight_All('32', 'E', 'A', '660', '720')=1;
Flight_All('33', 'E', 'F', '1020', '1080')=1;
Flight_All('34', 'C', 'F', '960', '1020')=1;
Flight_All('35', 'C', 'A', '840', '930')=1;
Flight_All('36', 'F', 'D', '630', '690')=1;
Flight_All('37', 'F', 'E', '1020', '1080')=1;
Flight_All('38', 'F', 'A', '1340', '1400')=1;
Flight_All('39', 'C', 'A', '1260', '1320')=1;
Flight_All('40', 'F', 'A', '1240', '1300')=1;

Parameter Flight(F, c1, c2, t1, t2);
Flight(F, c1, c2, t1, t2)=0;

Parameter Time_Solution(F);
Time_Solution(F)=0;

Parameter Iteration_Solution(F);
Iteration_Solution(F)=0;

Parameter Cost_Solution(F);
Cost_Solution(F)=0;