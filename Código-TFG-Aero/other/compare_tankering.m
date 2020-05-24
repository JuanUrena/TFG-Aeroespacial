Num_F={'3-1','7-15','10-22','12-36','15-55'};
Num_LOF={1, 15, 22, 36, 55};

model_time = [1.232, 3.308, 4.526, 8.118, 13.477];

model_flight = [0.073, 0.174, 0.188, 0.191, 0.208];

gan=100-(model_flight./model_time)*100;

axi=[1:size(model_flight,2)];
%
figure;
plot(axi, model_time, '-o', axi, model_flight,'-x');  
xticks(axi)
xticklabels(Num_LOF);
title('Comparativa tiempos de ejecución ');
xlabel('Número de LOF');
ylabel('t(s)');
legend('Tankering con Función temporal', 'Tankering con Función basada en conexiones', 'location', 'northwest');


figure;
plot(axi, gan, '-o');  
xticks(axi)
xticklabels(Num_LOF);
title('Reducción tiempo de ejecución');
ytickformat('percentage')
xlabel('Número de LOF');