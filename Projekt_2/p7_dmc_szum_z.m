clear;
kk = 160;
Tp=0.5;
time=0:Tp:Tp*(kk-1);
k_z_step=51;

% Symulacja dla y_zad=1
yzad = 1;
z(1:kk+7)=0;

% parametry DMC
% N = 8;
% Nu = 1;
% D = 192;
% lambda = 0.0023567;
N = 20;
Nu = 3;
D = 192;
lambda = 0.5;
Dz = 35;

% Symulacja dla z_szum_max_val=0.1
z_szum_max_val = 0.01;

[y, u] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz, z);
[yz, uz, z_szum] = p7_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz, z, z_szum_max_val);

% wyniki symulacji
figure; 
stairs(time,u, '-'); hold on; 
stairs(time,uz, '--');
stairs(time,z_szum, '-');
ylabel('u, z'); xlabel('t [s]'); grid on; grid minor;
legend('u: DMC bez szumu', 'u: DMC z szumem', 'pomiar z', 'Location','northwest');
title('Sygnały wejściowe'); % Tytuł wykresu
zamien_kropki();
exportgraphics(gcf, 'Wykresy/Z7_DMC_u_m.pdf', 'ContentType', 'vector');
close;

figure; 
stairs(time, y, '-'); hold on;
stairs(time, yz, '-.');
stairs(time, yzad * ones(kk, 1), '--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: DMC bez szumu', 'y: DMC z szumem', 'y_{zad}', 'Location','northwest');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/Z7_DMC_y_m.pdf', 'ContentType', 'vector');
close;

E = (yzad-y')'*(yzad-y');
Ez = (yzad-yz')'*(yzad-yz');

disp(['Błąd DMC bez szumu: ', num2str(E)]);
disp(['Błąd DMC z szumem: ', num2str(Ez)]);

% Symulacja dla z_szum_max_val=0.05
z_szum_max_val = 0.05;

[y, u] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz, z);
[yz, uz, z_szum] = p7_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz, z, z_szum_max_val);

% wyniki symulacji
figure; 
stairs(time,u, '-'); hold on; 
stairs(time,uz, '--');
stairs(time,z_szum, '-');
ylabel('u, z'); xlabel('t [s]'); grid on; grid minor;
legend('u: DMC bez szumu', 'u: DMC z szumem', 'pomiar z', 'Location','northwest');
title('Sygnały wejściowe'); % Tytuł wykresu
zamien_kropki();
exportgraphics(gcf, 'Wykresy/Z7_DMC_u_d.pdf', 'ContentType', 'vector');
close;

figure; 
stairs(time, y, '-'); hold on;
stairs(time, yz, '-.');
stairs(time, yzad * ones(kk, 1), '--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: DMC bez szumu', 'y: DMC z szumem', 'y_{zad}', 'Location','northwest');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/Z7_DMC_y_d.pdf', 'ContentType', 'vector');
close;

E = (yzad-y')'*(yzad-y');
Ez = (yzad-yz')'*(yzad-yz');

disp(['Błąd DMC bez szumu: ', num2str(E)]);
disp(['Błąd DMC z szumem: ', num2str(Ez)]);