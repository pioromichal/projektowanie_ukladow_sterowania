clear all

% inicjalizacja
kk = 1200;
yzad1(1:200)=1;yzad1(201:400)=3;yzad1(401:600)=0.5;yzad1(601:800)=-0.5;
yzad1(801:1000)=1.5;yzad1(1001:kk)=4;
yzad2(1:200)=1;yzad2(201:400)=3;yzad2(401:600)=0.5;yzad2(601:800)=-0.5;
yzad2(801:1000)=1.5;yzad2(1001:kk)=4;
yzad3(1:200)=1;yzad3(201:400)=3;yzad3(401:600)=0.5;yzad3(601:800)=-0.5;
yzad3(801:1000)=1.5;yzad3(1001:kk)=4;
Y_zad = [yzad1; yzad2; yzad3];
Tp=0.5;
y1(1:4)=0; y2(1:4)=0; y3(1:4)=0;

% nastawy
K=[6.5, 4.5, 2.5];
Ti=[25 45 60];
Td=[0.0 0.0 0.0];

U_nums=[4,2,1]; % które wejście wpływa na kolejne wyjścia

% symulacja
[Y,U,E] = p3_PID_MIMO(kk,Tp,Y_zad,K,Ti,Td,U_nums);

t=0:Tp:(kk-1)*Tp;
figure;
plot(1:kk, Y(1,:)); hold on;
plot(1:kk, Y(2,:));
plot(1:kk, Y(3,:));
plot(1:kk, yzad1); % wartość zadana taka sama dla każdego wyjścia
xlabel('k');
ylabel('Wartości wyjściowe');
legend('y1', 'y2', 'y3', 'y_{zad}', Location='best');
title('Wykres wartości wyjściowych');
grid on;
% exportgraphics(gcf, 'Wykresy/p4_y_7.pdf', 'ContentType', 'vector');
% close;

% Wykres wartości sterowania
figure;
plot(1:kk, U(1,:)); hold on;
plot(1:kk, U(2,:));
plot(1:kk, U(3,:));
plot(1:kk, U(4,:));
xlabel('k');
ylabel('Wartości sterowania');
legend('u1', 'u2', 'u3', 'u4', Location='best');
title('Wykres wartości sterowania');
grid on;
% exportgraphics(gcf, 'Wykresy/p4_u_7.pdf', 'ContentType', 'vector');
% close;