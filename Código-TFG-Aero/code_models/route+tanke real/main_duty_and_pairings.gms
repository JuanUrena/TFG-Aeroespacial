$title main_problem_2

$include set.gms
$include data.gms

Variables
ActiveDuti(D)
ActivePairing(P)
TotalCost
;

Binary variable ActiveDuti(D)
Binary variable ActivePairing(P)
Free Variable TotalCost
;

Equations

of
rescover
usingduti
;

of.. TotalCost =e=  sum((D),CostOfDurty(D)*ActiveDuti(D))
                    + sum(P(P), CostOfPairing(P)* ActivePairing(P));

rescover(F).. sum(D, FinDuty(F,D)*ActiveDuti(D)) =e= 1;
usingduti(D).. sum(P $ DutyinPairing(D, P), ActivePairing(P))=e= ActiveDuti(D);

option optcr = 0;

model main_problem_2 /all/;
solve main_problem_2 minimizing TotalCost using RMIP;
display TotalCost.l, ActiveDuti.l, rescover.m