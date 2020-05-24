$include set.gms
$include data.gms

*Especificar número de rutas en Data

Positive variable reposted_combustible(D, C, time);
Positive variable comb_aircraft(D, time);
Free variable z;

Equations
of
flow
inicio
capacity;

of.. z=e=sum((D, C, time),reposted_combustible(D, C, time)*Price_comb(C));

inicio(D).. comb_aircraft(D,'400')=e=0;

flow(D,time)$time_less(time).. comb_aircraft(D, time)+ sum (F$duties(D, F),
                                 sum((c1, c2, t2)$Flight(F, c1, c2, time, t2),reposted_combustible(D,  c1, time))-
                                 sum((c3, c1, t3)$Flight(F, c3, c1, t3, time),consum_comb(c3, c1)))=e=comb_aircraft(D, time+1);



capacity(D,time).. comb_aircraft(D,time)=l=120;
option limrow = 1400;
option optcr = 0;
model generation_duty /all/
solve generation_duty minimizing z using LP;
display reposted_combustible.l
