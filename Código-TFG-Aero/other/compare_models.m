cmp_file= 'omp_model.xlsx';

N=30;
c_lof=[600, 400, 200];
c_aero=[400, 250, 150];

n_vuelos=[20, 30, 40];

t_600=table2array(readtable(cmp_file,'Range','B2:C5'));
t_400=table2array(readtable(cmp_file,'Range','B9:C12'));
t_200=table2array(readtable(cmp_file,'Range','B16:C19'));

i_600=table2array(readtable(cmp_file,'Range','D2:E5'));
i_400=table2array(readtable(cmp_file,'Range','D9:E12'));
i_200=table2array(readtable(cmp_file,'Range','D16:E19'));

s_600=table2array(readtable(cmp_file,'Range','F2:G5'));
s_400=table2array(readtable(cmp_file,'Range','F9:G12'));
s_200=table2array(readtable(cmp_file,'Range','F16:G19'));

a=figure;
subplot(3,3,1);
plot(n_vuelos,t_200(:,1), '-o', n_vuelos, t_200(:,2), '-x')
title('Tiempo de ejecución');
h = text(-0.25, 0.5, 'Coste_LOF=200');
set(h, 'rotation', 90)
subplot(3,3,2);
plot(n_vuelos,i_200(:,1), '-o', n_vuelos, i_200(:,2), '-x')
title('LOFs generadas');
subplot(3,3,3);
plot(n_vuelos,s_200(:,1), '-o', n_vuelos, s_200(:,2), '-x')
title('Coste mínimo');

subplot(3,3,4);
h = text(-0.25, 0.5, 'Coste_{LOF}=400');
set(h, 'rotation', 90)
subplot(3,3,4);
plot(n_vuelos,t_400(:,1), '-o', n_vuelos, t_400(:,2), '-x')
subplot(3,3,5);
plot(n_vuelos,i_400(:,1), '-o', n_vuelos, i_400(:,2), '-x')
subplot(3,3,6);
plot(n_vuelos,s_400(:,1), '-o', n_vuelos, s_400(:,2), '-x')

subplot(3,3,7);
plot(n_vuelos,t_600(:,1), '-o', n_vuelos, t_600(:,2), '-x')
h = text(-0.25, 0.5, 'Coste_LOF=600');
set(h, 'rotation', 90)
subplot(3,3,8);
plot(n_vuelos,i_600(:,1), '-o', n_vuelos, i_600(:,2), '-x')
subplot(3,3,9);
plot(n_vuelos,s_600(:,1), '-o', n_vuelos, s_600(:,2), '-x')
%%
a=figure;
subplot(3,3,1);
plot(n_vuelos,t_200(:,1)./t_200(:,2)*100, '-x')
title('Tiempo de ejecución');
h = text(-0.25, 0.5, 'Coste_LOF=200');
set(h, 'rotation', 90)
subplot(3,3,2);
plot(n_vuelos,i_200(:,1)./i_200(:,2)*100, '-x')
title('LOFs generadas');
subplot(3,3,3);
plot(n_vuelos,s_200(:,1)./s_200(:,2)*100, '-x')
title('Coste mínimo');

subplot(3,3,4);
h = text(-0.25, 0.5, 'Coste_{LOF}=400');
set(h, 'rotation', 90)
subplot(3,3,4);
plot(n_vuelos,t_400(:,1)./t_400(:,2)*100, '-x')
subplot(3,3,5);
plot(n_vuelos,i_400(:,1)./i_400(:,2)*100, '-x')
subplot(3,3,6);
plot(n_vuelos,s_400(:,1)./s_400(:,2)*100, '-x')

subplot(3,3,7);
plot(n_vuelos,t_600(:,1)./t_600(:,2)*100, '-x')
h = text(-0.25, 0.5, 'Coste_LOF=600');
set(h, 'rotation', 90)
subplot(3,3,8);
plot(n_vuelos,i_600(:,1)./i_600(:,2)*100, '-x')
subplot(3,3,9);
plot(n_vuelos,s_600(:,1)./s_600(:,2)*100, '-x')