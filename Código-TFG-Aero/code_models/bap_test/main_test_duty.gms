$title main_problem

$include set.gms
$include data.gms

Variables
Used_duti(D)
TotalCost
reposted_combustible(D, F)
comb_aircraft(D,F)
;

Binary variable Used_duti(D)
Free Variable TotalCost
Binary Variable conex(f1, F)
Positive variable reposted_combustible(D,F)
Positive variable comb_aircraft(D,F)
;

Equations

of
rescover(F)
flow(D,F)
;

of.. TotalCost =e=  sum(D,Used_duti(D)* sum(F$duties_test(D,F), sum(C$Departure(F,C),reposted_combustible(D, F)*Price_comb(C) ) ) );
*of.. TotalCost =e=  sum((D)$Active_duties(D),Used_duti(D));
rescover(F).. sum(D, duties_test(D,F)*Used_duti(D)) =e= 1;
*rescover(F).. sum(D, duties(D,F)*Used_duti(D)) =e= 1;
flow(D,F)$duties_test(D,F).. reposted_combustible(D, F)+ sum(f1$connec_test(f1,F,D), comb_aircraft(D,f1))=e=sum((c1, c2, t1, t2)$Flight(F, c1, c2, t1, t2), consum_comb(c1, c2))+comb_aircraft(D,F);


option optcr = 0;

model main_problem /of, rescover, flow/;
solve main_problem minimizing TotalCost using MINLP;
display TotalCost.l, Used_duti.l, rescover.m, reposted_combustible.l
