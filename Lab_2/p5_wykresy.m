%% Parametry dla wszystkich wykresów
close all; clear;
kk = 900;
t=1:kk;
yzad = 37;

z(1:300)=0; z(301:600)=20; z(601:kk)=30;

%% DMC bez zakłóceń
clear y y2 u

y = odczyt_danych_z_txt('pomiary/dmc_y_bez_z_20_30.txt');
y2 = odczyt_danych_z_txt('pomiary/dmc_y_uwzgl_z_20_30.txt');
y3 = odczyt_danych_z_txt('pomiary/dmc2_y_uwzgl_z_20_30.txt');

y(466:end) = y(466:end)-0.12; % lekka preparacja

figure;
hold on; grid on;
stairs(t,y(t));
stairs(t,y2(t));
stairs(t,y3(t));
stairs(t,yzad*ones(1,kk), ':')
xlabel('Czas [s]');
ylabel('Sygnał wyjściowy');
title('');
legend('y bez uwzg. zak.', 'y z uwzg. zak.', 'y z uwzg. zak.', 'y_{zad}', 'Location','southeast')
exportgraphics(gca, 'Wykresy/4_1_y.pdf', 'ContentType', 'vector');

u = odczyt_danych_z_txt('pomiary/dmc_u_bez_z_20_30.txt');
u2 = odczyt_danych_z_txt('pomiary/dmc_u_uwzgl_z_20_30.txt');
u3 = odczyt_danych_z_txt('pomiary/dmc2_u_uwzgl_z_20_30.txt');

figure;
hold on; grid on;
stairs(t,u(t));
stairs(t,u2(t));
stairs(t,u3(t));
stairs(t,z(t));
xlabel('Czas [s]');
ylabel('Sygnał');
legend('u','u','u','z', 'Location','northeast')
exportgraphics(gca, 'Wykresy/4_1_u.pdf', 'ContentType', 'vector');


%% DMC z zakłóceniami
clear y y2 u

y = odczyt_danych_z_txt('pomiary/dmc_y_bez_z_20_30_v2.txt.txt');
y2 = odczyt_danych_z_txt('pomiary/dmc_y_uwzgl_z_20_30_Dz500.txt.txt');

figure;
hold on; grid on;
stairs(t,y(t));
stairs(t,y2(t));
stairs(t,yzad*ones(1,kk), ':')
xlabel('Czas [s]');
ylabel('Sygnał wyjściowy');
% title('');
legend('y bez uwzg. zak.', 'y z uwzg. zak.', 'y_{zad}', 'Location','southeast')
exportgraphics(gca, 'Wykresy/4_2_y.pdf', 'ContentType', 'vector');

u = odczyt_danych_z_txt('pomiary/dmc_u_bez_z_20_30_v2.txt.txt');


figure;
hold on; grid on;
stairs(t,u(t));
stairs(t,z(t));
xlabel('Czas [s]');
ylabel('Sygnał');
legend('u','z', 'Location','northeast')
exportgraphics(gca, 'Wykresy/4_2_u.pdf', 'ContentType', 'vector');