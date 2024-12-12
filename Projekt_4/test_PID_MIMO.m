addpath('Funkcje')
clear all;
kk = 200;
Tp=0.5;

U = zeros(4, kk); % macierz dla u1, u2, u3, u4 
y1(1:4)=0; y2(1:4)=0; y3(1:4)=0;
y1_zad(1:kk)=0; y2_zad(1:kk)=0; y3_zad(1:kk)=10;
Y_zad=[y1_zad;y2_zad;y3_zad];
E=zeros(3,kk);

% PID 1 Z-N
% K=[12.028 0 0];

% PID 2 Z-N
% K=[0 11.205 0];

% PID 3 Z-N
% K=[0 0 35.792];
Ti=[999999 999999 999999];
Td=[0 0 0];

[R2,R1,R0]=PID_MIMO_offline(K,Ti,Td,Tp);

U_nums=[4,2,1];
Y_nums=[1,2,3];

for k=5:kk
    [y1(k), y2(k), y3(k)] = symulacja_obiektu15y_p4( ...
            U(1, k-1), U(1, k-2), U(1, k-3), U(1, k-4), ...
            U(2, k-1), U(2, k-2), U(2, k-3), U(2, k-4), ...
            U(3, k-1), U(3, k-2), U(3, k-3), U(3, k-4), ...
            U(4, k-1), U(4, k-2), U(4, k-3), U(4, k-4), ...
            y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
            y2(k-1), y2(k-2), y2(k-3), y2(k-4), ...
            y3(k-1), y3(k-2), y3(k-3), y3(k-4));
    Y=[y1(k);y2(k);y3(k)];
    
   
    % PID 1 u1->y3
    % PID 2 u2->y2    
    % PID 3 u4->y3
    [U,E]=PID_MIMO_U(k,Y,Y_zad,U,E,R0,R1,R2,U_nums);
end

t=0:Tp:(kk-1)*Tp;
figure;
plot(t, y1); hold on;
plot(t, y2);
plot(t, y3);
xlabel('Krok czasowy');
ylabel('Wartości wyjściowe');
legend('y1', 'y2', 'y3');
title('Wykres wartości wyjściowych');
grid on;

% Wykres wartości sterowania
figure;
plot(t, U(1,:)); hold on;
plot(t, U(2,:));
plot(t, U(3,:));
plot(t, U(4,:));
xlabel('k');
ylabel('Wartości sterowania');
legend('u1', 'u2', 'u3', 'u4');
title('Wykres wartości sterowania');
grid on;