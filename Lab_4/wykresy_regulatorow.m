clear; close all;

colors=lines(2);

%% PID 1
load("Pomiary\PID_niepelne_5_100_01.mat");

figure;hold on;grid on; grid minor;
plot(y1,'DisplayName','y1');plot(y2,'DisplayName','y2');plot(yz1,'DisplayName','yz1');plot(yz2,'DisplayName','yz2');


%% PID 2
load("Pomiary\PID_6_80_01.mat");

figure;hold on;grid on; grid minor;
plot(y1(15:1214),'Color',colors(1,:));
plot(yz1(15:1214),'--','Color',colors(1,:));
plot(y2(15:1214),'Color',colors(2,:));
plot(yz2(15:1214),'--','Color',colors(2,:));
xlabel('Czas [s]'); ylabel('y');
legend('y1','y1_{zad}','y2','y1_{zad}', Location='best');
exportgraphics(gcf, 'Wykresy/pid_6_80_01_y.pdf', 'ContentType', 'vector');

figure;hold on;grid on; grid minor;
plot(u1(15:1214));plot(u2(15:1214));
xlabel('Czas [s]'); ylabel('u');
legend('u1','u2', Location='best');
exportgraphics(gcf, 'Wykresy/pid_6_80_01_u.pdf', 'ContentType', 'vector');


%% DMC
load("Pomiary\DMC_niepelny.mat");

figure;hold on;grid on; grid minor;
plot(y1,'Color',colors(1,:));
plot(yz1,'--','Color',colors(1,:));
plot(y2,'Color',colors(2,:));
plot(yz2,'--','Color',colors(2,:));
xlabel('Czas [s]'); ylabel('y');
legend('y1','y1_{zad}','y2','y1_{zad}', Location='best');
exportgraphics(gcf, 'Wykresy/DMC_1_y.pdf', 'ContentType', 'vector');

figure;hold on;grid on; grid minor;
plot(u1);plot(u2);
xlabel('Czas [s]'); ylabel('u');
legend('u1','u2', Location='best');
exportgraphics(gcf, 'Wykresy/DMC_1_u.pdf', 'ContentType', 'vector');