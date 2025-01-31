clear; close all
kk = 100;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

% Symulacja dla y_zad=1
yzad = 1;

% parametry DMC poza Dz
% N = 8;
% Nu = 1;
% D = 192;
% lambda = 0.0023567;
N = 20;
Nu = 3;
D = 192;
lambda = 0.5;

% testowane choryzonty dynamiki zakłoćeń Dz

Dz = [5 10 30];

% Symulacja dla z=1
z(1:50)=0;z(51:kk+7)=1;

[y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda, z);
[y1, u1] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz(1), z);
[y2, u2] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz(2), z);
[y3, u3] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz(3), z);
% [y4, u4] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz(4), z);
% [y5, u5] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz(5), z);


% wyniki symulacji
figure; 
stairs(time,u, '-'); hold on; 
stairs(time,u1, '--'); 
stairs(time,u2, '--'); 
stairs(time,u3, '--');
% stairs(time,u4, '-');
% stairs(time,u5, ':');
stairs(time,z(8:end), '--');
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: brak Dz',sprintf('u: Dz=%d', Dz(1)), sprintf('u: Dz=%d', Dz(2)), ...
       sprintf('u: Dz=%d', Dz(3)), 'z', 'Location','northeast');
title('Sygnały wejściowe'); % Tytuł wykresu
zamien_kropki();
exportgraphics(gcf, 'Wykresy/Z5_DMC_u_m.pdf', 'ContentType', 'vector');
% close;

figure; 
stairs(time, y, '-'); hold on;
stairs(time, y1, '-');
stairs(time, y2, '-');
stairs(time, y3, '-');
% stairs(time, y4, '-.');
% stairs(time, y5, ':');
stairs(time, yzad * ones(kk, 1), '--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: brak Dz',sprintf('y: Dz=%d', Dz(1)), sprintf('y: Dz=%d', Dz(2)), ...
       sprintf('y: Dz=%d', Dz(3)), 'y_{zad}', 'Location','northwest');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/Z5_DMC_y_m.pdf', 'ContentType', 'vector');
% close;

E = (yzad-y')'*(yzad-y');
E1 = (yzad-y1')'*(yzad-y1');
E2 = (yzad-y2')'*(yzad-y2');
E3 = (yzad-y3')'*(yzad-y3');

disp(['Błąd DMC bez Dz: ', num2str(E)]);
disp(['Błąd DMC 1: ', num2str(E1)]);
disp(['Błąd DMC 2: ', num2str(E2)]);
disp(['Błąd DMC 3: ', num2str(E3)]);


%% aaaa
Dz = [25 30 35];

% Symulacja dla z=1
z(1:50)=0;z(51:kk+7)=1;

[y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda, z);
[y1, u1] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz(1), z);
[y2, u2] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz(2), z);
[y3, u3] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz(3), z);

% wyniki symulacji
figure; 
stairs(time,u, '-'); hold on; 
stairs(time,u1, '--'); 
stairs(time,u2, '--'); 
stairs(time,u3, '--');
xlim([25 50]); ylim([-0.2 0]);
stairs(time,z(8:end), '--');
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: brak Dz',sprintf('u: Dz=%d', Dz(1)), sprintf('u: Dz=%d', Dz(2)), ...
       sprintf('u: Dz=%d', Dz(3)), 'z', 'Location','southeast');
title('Sygnały wejściowe'); % Tytuł wykresu
zamien_kropki();
exportgraphics(gcf, 'Wykresy/Z5_DMC_u_d.pdf', 'ContentType', 'vector');
% close;

figure; 
stairs(time, y, '-'); hold on;
stairs(time, y1, '-');
stairs(time, y2, '-');
stairs(time, y3, '-');
xlim([25 50]); ylim([0.95 1.05]);
stairs(time, yzad * ones(kk, 1), '--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: brak Dz',sprintf('y: Dz=%d', Dz(1)), sprintf('y: Dz=%d', Dz(2)), ...
       sprintf('y: Dz=%d', Dz(3)), 'y_{zad}', 'Location','southwest');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/Z5_DMC_y_d.pdf', 'ContentType', 'vector');
% close;

E = (yzad-y')'*(yzad-y');
E1 = (yzad-y1')'*(yzad-y1');
E2 = (yzad-y2')'*(yzad-y2');
E3 = (yzad-y3')'*(yzad-y3');

disp(['Błąd DMC bez Dz: ', num2str(E)]);
disp(['Błąd DMC 1: ', num2str(E1)]);
disp(['Błąd DMC 2: ', num2str(E2)]);
disp(['Błąd DMC 3: ', num2str(E3)]);