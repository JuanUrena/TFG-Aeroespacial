vuelos_file= 'vuelos.xlsx';

cities_connex=readtable(vuelos_file);
%
cities=table2array(cities_connex(1:16,2));
%
times=table2array(cities_connex(:,5));
t_connec=zeros(16);

for i=1:16
    for j=1:16
        if i>j
            y=i;
            x=j;
        else
            x=i;
            y=j;            
        end
        t_connec(i,j)=times((x-1)*16+y);
    end
end
%%
vuelos_g=zeros(100, 6);
% Vuelos del hub D
%
count_f=1;
b_p=[300, 600, 900];
for b= b_p
    for i=1:6
        if not(i==4)
            p=(randi(21)-1)*15;
            vuelos_g(count_f,1)=count_f;
            vuelos_g(count_f,2)=i;
            vuelos_g(count_f,3)=4;
            vuelos_g(count_f,4)=b+p;
            vuelos_g(count_f,5)=round(b+p+t_connec(i,4));
            vuelos_g(count_f,6)=1;
            count_f=count_f+1;

            p=(randi(21)-1)*15;
            vuelos_g(count_f,1)=count_f;
            vuelos_g(count_f,2)=4;
            vuelos_g(count_f,3)=i;
            vuelos_g(count_f,4)=b+p;
            vuelos_g(count_f,5)=round(b+p+t_connec(4,i));
            vuelos_g(count_f,6)=1;
            count_f=count_f+1;
        end
    end

    for i=7:16
        if not(i==10)
            p=(randi(21)-1)*15;
            vuelos_g(count_f,1)=count_f;
            vuelos_g(count_f,2)=i;
            vuelos_g(count_f,3)=4;
            vuelos_g(count_f,4)=b+p;
            vuelos_g(count_f,5)=round(b+p+t_connec(i,10));
            vuelos_g(count_f,6)=1;
            count_f=count_f+1;

            p=(randi(21)-1)*15;
            vuelos_g(count_f,1)=count_f;
            vuelos_g(count_f,2)=4;
            vuelos_g(count_f,3)=i;
            vuelos_g(count_f,4)=b+p;
            vuelos_g(count_f,5)=round(b+p+t_connec(10,i));
            vuelos_g(count_f,6)=1;
            count_f=count_f+1;
        end
    end
end

b_p=[360, 480, 600, 720, 840, 960, 1080, 1200];

for b=b_p
            p=(randi(5)-1)*15;
            vuelos_g(count_f,1)=count_f;
            vuelos_g(count_f,2)=10;
            vuelos_g(count_f,3)=4;
            vuelos_g(count_f,4)=b+p;
            vuelos_g(count_f,5)=round(b+p+t_connec(10,4));
            vuelos_g(count_f,6)=1;
            count_f=count_f+1;

            p=(randi(5)-1)*15;
            vuelos_g(count_f,1)=count_f;
            vuelos_g(count_f,2)=4;
            vuelos_g(count_f,3)=10;
            vuelos_g(count_f,4)=b+p;
            vuelos_g(count_f,5)=round(b+p+t_connec(4,10));
            vuelos_g(count_f,6)=1;
            count_f=count_f+1;
end

%
vuelos_hubs=array2table(vuelos_g);
%
filename = 'vuelos_hubs.xlsx';
writetable(vuelos_hubs, filename);
%%
d=table2array(cities_connex(:,3));
dij=zeros(16*16,3);

for i=1:16
    for j=1:16
        if i>j
            y=i;
            x=j;
        else
            x=i;
            y=j;            
        end
        
        dij((i-1)*16+j,1)=i; 
        dij((i-1)*16+j,2)=j;
        dij((i-1)*16+j,3)=d((x-1)*16+y);
    end
end

dij_table=array2table(dij);
filename = 'dij.xlsx';
writetable(dij_table, filename);

%%
vuelos_g=zeros(100, 6);
count_f=1;

b_p=[300, 540, 780, 1020, 1260];
for b=b_p
    g=1;
    while g<21
        o=randi(16);
        d=randi(16);
        if (not(o==d) && t_connec(o,d)>60)
            p=(randi(25)-1)*10;
            vuelos_g(count_f,1)=count_f;
            vuelos_g(count_f,2)=o;
            vuelos_g(count_f,3)=d;
            vuelos_g(count_f,4)=b+p;
            vuelos_g(count_f,5)=round(b+p+t_connec(o,d));
            vuelos_g(count_f,6)=1;
            count_f=count_f+1;
            g=g+1;
        end
    end
end
vuelos_aleat=array2table(vuelos_g);
%
filename = 'vuelos_alat.xlsx';
writetable(vuelos_aleat, filename);

