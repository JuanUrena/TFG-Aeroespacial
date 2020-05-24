$title comb_duty

*$include set.gms
*$include data.gms

Positive variable reposted_combustible(C, time);
Positive variable comb_aircraft(time);
Free variable cost_combustible;

Equations
of2
flow
inicio
capacity;

of2.. cost_combustible=e=sum((C,time),reposted_combustible(C, time)*Price_comb(C));

inicio.. comb_aircraft('1')=e=0;

flow(time)$time_less(time).. comb_aircraft(time)+ sum (D$Selected_duty_comb(D),sum (F$duties(D, F),
                                 sum((c1, c2, t2)$Flight(F, c1, c2, time, t2),reposted_combustible(c1, time))-
                                 sum((c3, c1, t3)$Flight(F, c3, c1, t3, time),consum_comb(c3, c1))))=e=comb_aircraft(time+1);



capacity(time).. comb_aircraft(time)=l=100000;

option optcr = 0;
model comb_duty /of2, inicio, flow, capacity/
*solve comb_duty minimizing cost_combustible using MIP;
*display reposted_combustible.l, cost_combustible.l
