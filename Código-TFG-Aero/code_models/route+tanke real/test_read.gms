set f /1*100/;
set a /1*16/;
set t /300*1810/;

alias(a, a1);
alias(t, t1);






$call gdxxrw.exe vuelos_alat.xlsx par=vuelos rng=A2:E101 rdim=5
*$call gdxxrw.exe vuelos_hubs.xlsx par=vuelos rng=A2:E101 rdim=5
Parameter flight(f, a, a1, t, t1);
execute_load "vuelos_alat" flight=vuelos;
*execute_load "vuelos_hubs" flight=vuelos;
execute_unload "Flight" flight;

$call gdxxrw.exe dij.xlsx par=d rng=A2:C257 rdim=2
Parameter d(a, a1);
execute_load "dij" d;

display flight, d;
