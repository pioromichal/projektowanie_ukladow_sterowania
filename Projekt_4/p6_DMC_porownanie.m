clear all
addpath('Funkcje')
set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
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
D = 200; N = 8; Nu = 4;
lambda=[1 1 1 1]; psi=[1 1 1];

% symulacja
[Y,U,E] = p3_DMC_MIMO(kk, Y_zad, D, N, Nu, lambda, psi);
[Yc,Uc,Ec] = p6_DMC_MIMO_full_y_zad(kk, Y_zad, D, N, Nu, lambda, psi);

disp(E)
disp(Ec)

t = 0:Tp:(kk-1)*Tp;


% Wykresy wartości wyjściowych
for i = 1:3
    figure;
    plot(1:kk, Y(i,:), 'DisplayName', sprintf('Oszczędny DMC: y_%d', i)); hold on;
    plot(1:kk, Yc(i,:), '--', 'DisplayName', sprintf('Klasyczny DMC: y_%d', i));
    plot(1:kk, Y_zad(i,:), ':', 'DisplayName', sprintf('y_{%dzad}', i));
    xlabel('k');
    ylabel(sprintf('y%d', i));
    legend(Location='best');
    title(sprintf('Porównanie wartości wyjściowych: y_%d (Oszczędny DMC vs Klasyczny DMC)', i));
    grid on;
    exportgraphics(gcf, sprintf('Wykresy/p4_y%d_comparison_dmc.pdf', i), 'ContentType', 'vector');
    close;
end

% Wykresy wartości sterowań
for i = 1:4
    figure;
    plot(1:kk, U(i,:), 'DisplayName', sprintf('Oszczędny DMC: u_%d', i)); hold on;
    plot(1:kk, Uc(i,:), '--', 'DisplayName', sprintf('Klasyczny DMC: u_%d', i));
    xlabel('k');
    ylabel(sprintf('u%d', i));
    legend(Location='best');
    title(sprintf('Porównanie wartości sterowania: u_%d (Oszczędny DMC vs Klasyczny DMC)', i));
    grid on;
    exportgraphics(gcf, sprintf('Wykresy/p4_u%d_comparison_dmc.pdf', i), 'ContentType', 'vector');
    close;
end