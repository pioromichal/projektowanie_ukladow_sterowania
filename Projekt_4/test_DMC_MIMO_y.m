addpath('Funkcje')

kk = 250;

y1_zad(1:kk)=10; y2_zad(1:kk)=0; y3_zad(1:kk)=0;
Y_zad=[y1_zad;y2_zad;y3_zad];
% D=200; N=D; Nu=N; 
D=200; N=100; Nu=50; 
lambda=[1 1 1 1]; psi=[1 1 1];

[Y,U,E] = p6_DMC_MIMO_full_y_zad(kk,Y_zad,D,N,Nu,lambda,psi);

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