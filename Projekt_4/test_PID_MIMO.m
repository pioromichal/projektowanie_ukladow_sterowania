addpath('Funkcje')
clear all;
kk = 50;
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
% K=[1 1 1];
Ti=[999999 999999 999999];
Td=[0 0 0];

K_u=[12.028, 11.205, 35.792];
T_u=[2 2 2];
[K,Ti,Td] = PID_MIMO_ZN(K_u,T_u);

U_nums=[4,2,1];

[Y,U,E] = p3_PID_MIMO(kk,Tp,Y_zad,K,Ti,Td,U_nums);

t=0:Tp:(kk-1)*Tp;
figure;
plot(1:kk, Y(1,:)); hold on;
plot(1:kk, Y(2,:));
plot(1:kk, Y(3,:));
xlabel('Krok czasowy');
ylabel('Wartości wyjściowe');
legend('y1', 'y2', 'y3');
title('Wykres wartości wyjściowych');
grid on;

% Wykres wartości sterowania
figure;
plot(1:kk, U(1,:)); hold on;
plot(1:kk, U(2,:));
plot(1:kk, U(3,:));
plot(1:kk, U(4,:));
xlabel('k');
ylabel('Wartości sterowania');
legend('u1', 'u2', 'u3', 'u4');
title('Wykres wartości sterowania');
grid on;