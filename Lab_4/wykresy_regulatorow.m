clear; close all;

colors=lines(2);

%% PID 1 - dow wywalenia jak nalesnik
% load("Pomiary\PID_niepelne_5_100_01.mat");
% 
% figure;hold on;grid on; grid minor;
% plot(y1,'DisplayName','y1');plot(y2,'DisplayName','y2');plot(yz1,'DisplayName','yz1');plot(yz2,'DisplayName','yz2');


%% PID 2
load("Pomiary\PID_6_80_01.mat");
t=(15:1214);
figure;hold on;grid on; grid minor;
plot(y1(t),'Color',colors(1,:));
plot(yz1(t),'--','Color',colors(1,:));
plot(y2(t),'Color',colors(2,:));
plot(yz2(t),'--','Color',colors(2,:));
xlabel('Czas [s]'); ylabel('y');
ylim([34 54]);
legend('y1','y1_{zad}','y2','y2_{zad}', Location='best');
exportgraphics(gcf, 'Wykresy/pid_6_80_01_y.pdf', 'ContentType', 'vector');

figure;hold on;grid on; grid minor;
plot(u1(t));plot(u2(t));
xlabel('Czas [s]'); ylabel('u');
legend('u1','u2', Location='best');
exportgraphics(gcf, 'Wykresy/pid_6_80_01_u.pdf', 'ContentType', 'vector');
t=315:1214;
E = ((yz1(t) - y1(t))'*(yz1(t) - y1(t))+(yz2(t) - y2(t))'*(yz2(t) - y2(t)))/length(yz1);
disp(['K=6 Ti=80 E=' num2str(E)]);
%% PID 3
load('Pomiary\PID_5_100_01.mat')
t=13:1212;
figure;hold on;grid on; grid minor;
plot(y1(t),'Color',colors(1,:));
plot(yz1(t),'--','Color',colors(1,:));
plot(y2(t),'Color',colors(2,:));
plot(yz2(t),'--','Color',colors(2,:));
xlabel('Czas [s]'); ylabel('y');
ylim([34 54]);
legend('y1','y1_{zad}','y2','y2_{zad}', Location='best');
exportgraphics(gcf, 'Wykresy/pid_5_100_01_y.pdf', 'ContentType', 'vector');

figure;hold on;grid on; grid minor;
plot(u1(t));plot(u2(t));
xlabel('Czas [s]'); ylabel('u');
legend('u1','u2', Location='best');
exportgraphics(gcf, 'Wykresy/pid_5_100_01_u.pdf', 'ContentType', 'vector');
t=313:1212;
E = ((yz1(t) - y1(t))'*(yz1(t) - y1(t))+(yz2(t) - y2(t))'*(yz2(t) - y2(t)))/length(yz1);
disp(['K=5 Ti=100 E=' num2str(E)]);

%% PID 4
load('Pomiary\PID_8_70_01.mat')
t=(40:1239);
figure;hold on;grid on; grid minor;
plot(y1(t),'Color',colors(1,:));
plot(yz1(t),'--','Color',colors(1,:));
plot(y2(t),'Color',colors(2,:));
plot(yz2(t),'--','Color',colors(2,:));
xlabel('Czas [s]'); ylabel('y');
ylim([34 54]);
legend('y1','y1_{zad}','y2','y2_{zad}', Location='best');
exportgraphics(gcf, 'Wykresy/pid_8_70_01_y.pdf', 'ContentType', 'vector');

figure;hold on;grid on; grid minor;
plot(u1(t));plot(u2(t));
xlabel('Czas [s]'); ylabel('u');
legend('u1','u2', Location='best');
exportgraphics(gcf, 'Wykresy/pid_8_70_01_u.pdf', 'ContentType', 'vector');
t=340:1239;
E = ((yz1(t) - y1(t))'*(yz1(t) - y1(t))+(yz2(t) - y2(t))'*(yz2(t) - y2(t)))/length(yz1);
disp(['K=8 Ti=70 E=' num2str(E)]);

%% DMC 1 - niepelny
load("Pomiary\DMC_niepelny.mat");

figure;hold on;grid on; grid minor;
plot(y1,'Color',colors(1,:));
plot(yz1,'--','Color',colors(1,:));
plot(y2,'Color',colors(2,:));
plot(yz2,'--','Color',colors(2,:));
xlabel('Czas [s]'); ylabel('y');
ylim([35 55]);
legend('y1','y1_{zad}','y2','y2_{zad}', Location='best');
exportgraphics(gcf, 'Wykresy/DMC_1_y.pdf', 'ContentType', 'vector');

figure;hold on;grid on; grid minor;
plot(u1);plot(u2);
xlabel('Czas [s]'); ylabel('u');
legend('u1','u2', Location='best');
exportgraphics(gcf, 'Wykresy/DMC_1_u.pdf', 'ContentType', 'vector');

%% DMC 2 - lambda 05
load("Pomiary\DMC_lambda_05.mat");
t=11:1210;
figure;hold on;grid on; grid minor;
plot(y1(t),'Color',colors(1,:));
plot(yz1(t),'--','Color',colors(1,:));
plot(y2(t),'Color',colors(2,:));
plot(yz2(t),'--','Color',colors(2,:));
xlabel('Czas [s]'); ylabel('y');
legend('y1','y1_{zad}','y2','y2_{zad}', Location='best');
exportgraphics(gcf, 'Wykresy/DMC_05_y.pdf', 'ContentType', 'vector');

figure;hold on;grid on; grid minor;
plot(u1(t));plot(u2(t));
xlabel('Czas [s]'); ylabel('u');
legend('u1','u2', Location='best');
exportgraphics(gcf, 'Wykresy/DMC_05_u.pdf', 'ContentType', 'vector');