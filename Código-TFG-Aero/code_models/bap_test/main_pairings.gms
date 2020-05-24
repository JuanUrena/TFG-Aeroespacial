$title main_problem_3

$include set.gms
$include data.gms

Variables
ActivePairing(P)
TotalCost
;

Binary variable ActivePairing(P)
Free Variable TotalCost
;

Equations

of
rescover
;

of.. TotalCost =e= sum(P(P), CostOfPairing(P)* ActivePairing(P)+
                 sum(D,DutyinPairing(D,P)*ActivePairing(P)*CostOfDurty(D)));

rescover(F).. sum(D, sum ((P), DutyinPairing(D,P)* FinDuty(F,D)*ActivePairing(P))) =e= 1;
*Para saber si un F esta en un P, compruebo tambien si esta en D y si D esta en P

option optcr = 0;

model main_problem_3 /all/;
solve main_problem_3 minimizing TotalCost using RMIP;
display TotalCost.l, ActivePairing.l, rescover.m