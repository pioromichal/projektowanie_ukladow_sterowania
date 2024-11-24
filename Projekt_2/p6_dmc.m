clear;
kk = 160;
Tp=0.5;
time=0:Tp:Tp*(kk-1);
k_z_step=51;

% Symulacja dla y_zad=1
yzad = 1;

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

% Symulacja dla maks sin = 1
z(1:50)=0; z(51:kk+7)=sin(-2*pi:(4*pi/(kk-k_z_step+7)):2*pi);

[y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda, z);
[yz, uz] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz, z);

% wyniki symulacji
figure; 
stairs(time,u, '-'); hold on; 
stairs(time,uz, '-.'); 
stairs(time,z(8:end), '-.');
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: DMC bez pomiaru z', 'u: DMC z pomiarem z', 'z', 'Location','northwest');
title('Sygnały wejściowe'); % Tytuł wykresu
zamien_kropki();
exportgraphics(gcf, 'Wykresy/Z6_DMC_u_m.pdf', 'ContentType', 'vector');
% close;

figure; 
stairs(time, y, '-'); hold on;
stairs(time, yz, '-.');
stairs(time, yzad * ones(kk, 1), '--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: DMC bez pomiaru z', 'y: DMC z pomiarem z', 'y_{zad}', 'Location','northwest');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/Z6_DMC_y_m.pdf', 'ContentType', 'vector');
% close;

E = (yzad-y')'*(yzad-y');
Ez = (yzad-yz')'*(yzad-yz');

disp(['Błąd DMC bez Dz: ', num2str(E)]);
disp(['Błąd DMC z Dz: ', num2str(Ez)]);

% Symulacja dla maks sin = 4
z(1:50)=0; z(51:kk+7)=4*sin(-2*pi:(4*pi/(kk-k_z_step+7)):2*pi);

[y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda, z);
[yz, uz] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz, z);

% wyniki symulacji
figure; 
stairs(time,u, '-'); hold on; 
stairs(time,uz, '-.');
stairs(time,z(8:end), '-.');
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: DMC bez pomiaru z', 'u: DMC z pomiarem z', 'z', 'Location','northwest');
title('Sygnały wejściowe'); % Tytuł wykresu
zamien_kropki();
exportgraphics(gcf, 'Wykresy/Z6_DMC_u_d.pdf', 'ContentType', 'vector');
% close;

figure; 
stairs(time, y, '-'); hold on;
stairs(time, yz, '-.');
stairs(time, yzad * ones(kk, 1), '--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: DMC bez pomiaru z', 'y: DMC z pomiarem z', 'y_{zad}', 'Location','southwest');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/Z6_DMC_y_d.pdf', 'ContentType', 'vector');
% close;

E = (yzad-y')'*(yzad-y');
Ez = (yzad-yz')'*(yzad-yz');

disp(['Błąd DMC bez Dz: ', num2str(E)]);
disp(['Błąd DMC z Dz: ', num2str(Ez)]);