$title tanke

$include set.gms
$include data.gms

Parameter con_LOF(D,F,f1);
Scalar coste_scalar;
Parameter LOF(D,F)

execute_load 'Flight' Flight;
execute_load 'LOF.gdx' LOF
execute_load 'con_LOF.gdx' con_LOF
execute_load 'coste_scalar' coste_scalar
Parameter coste_ante;
coste_ante=coste_scalar;
display LOF, con_LOF, coste_scalar;

Positive variable reposted_combustible(D, F);
Positive variable comb_aircraft(D, F);
Free variable z;

Equations
of
flow
capacity
;


of.. z=e=coste_scalar+sum((D, F),reposted_combustible(D, F)*sum((c1, c2, t1, t2)$Flight(F, c1, c2, t1, t2),Price_comb(c1)));


flow(D,F)$LOF(D,F).. reposted_combustible(D, F) + sum(f1$con_LOF(D,f1,F), comb_aircraft(D,f1))=e=
         sum((c1, c2, t1, t2)$Flight(F, c1, c2, t1, t2),consum_comb(c1, c2))+comb_aircraft(D, F);


capacity(D,F)$LOF(D,F).. reposted_combustible(D,F)+ sum(f1$con_LOF(D,f1,F), comb_aircraft(D,f1))=l=6000;

option limrow = 1400;
option optcr = 0;
model generation_duty /all/
solve generation_duty minimizing z using LP;
display reposted_combustible.l, comb_aircraft.l, consum_comb
Parameter com_repo(D,F);
com_repo(D,F)=reposted_combustible.l(D,F);
execute_unload 'com_repo' com_repo;
