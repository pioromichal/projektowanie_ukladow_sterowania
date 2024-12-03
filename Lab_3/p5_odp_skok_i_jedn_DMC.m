addpath('Funkcje')

dane1 = load('Pomiary/skok_25_40.txt');
dane2 = load('Pomiary/skok_50_60.txt');
dane3 = load('Pomiary/skok_65_75.txt');

K = [0.44229, 0.32123, 0.22986];
Td = [7, 7, 7];
T1 = [10.2021, 6.8717, 15.3719];
T2 = [76.437, 110.917, 77.9063];

t1 = dane1(:, 1);
y1 = dane1(:, 2);
t2 = dane2(:, 1);
y2 = dane2(:, 2);
t3 = dane3(:, 1);
y3 = dane3(:, 2);

kk = 350;
figure;
hold on;
stairs(y1(1:kk)); % plot(model(T1(1),T2(1),K(1),Td(1),kk,u)); 
stairs(y2(1:kk));% plot(model(T1(2),T2(2),K(2),Td(2),kk,10)); 
stairs(y3(1:kk));% plot(model(T1(3),T2(3),K(3),Td(3),kk,10)); 
legend('y: Regulator 1', 'y: Regulator 2', 'y: Regulator 3', 'Location', 'southeast');
xlabel('Czas [s]');
ylabel('y');
grid on; grid minor;
title('Pobrane odpowiedzi skokowe do regulatorów DMC');

exportgraphics(gca, 'Wykresy/odpowiedzi_skokowe_DMC.pdf', 'ContentType', 'vector');
% close;

ys = dmc_odp_jednostkowa_rozm(kk);

figure;
plot(ys(:,1),'.',MarkerSize=1.5);
hold on;
plot(ys(:,2),'.',MarkerSize=1.5);
plot(ys(:,3),'.',MarkerSize=1.5);
legend('ys: Regulator 1', 'ys: Regulator 2', 'ys: Regulator 3', 'Location', 'southeast');
xlabel('k');
ylabel('ys');
title('Znormalizowane odpowiedzi skokowe do regulatorów DMC');

grid on; grid minor;

exportgraphics(gca, 'Wykresy/odpowiedzi_jednostkowe_DMC.pdf', 'ContentType', 'vector');