$include set.gms
$include data.gms

*Especificar número de rutas en Data

Positive variable reposted_combustible(D, F);
Positive variable comb_aircraft(D, F);
Free variable z;

Equations
of
flow
capacity;

of.. z=e=sum((D, F),reposted_combustible(D, F)*sum((c1, c2, t1, t2)$Flight(F, c1, c2, t1, t2),Price_comb(c1)));


flow(D,F)$duties(D,F).. reposted_combustible(D, F) + sum(f1$connec(D,f1,F), comb_aircraft(D,f1))=e=
         sum((c1, c2, t1, t2)$Flight(F, c1, c2, t1, t2),consum_comb(c1, c2))+comb_aircraft(D, F);


capacity(D,F)$duties(D,F).. reposted_combustible(D,F)+ sum(f1$connec(D,f1,F), comb_aircraft(D,f1))=l=120;

option limrow = 1400;
option optcr = 0;
model generation_duty /all/
solve generation_duty minimizing z using LP;
display reposted_combustible.l, comb_aircraft.l
