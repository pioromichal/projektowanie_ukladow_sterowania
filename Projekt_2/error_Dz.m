clear;
kk = 600;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

yzad = 1;
% yzad = yzad*ones(kk,1);

N = 8;
Nu = 1;
D = 192;
% Dz = 194;
lambda = 0.0023567;

z(1:20)=0; z(21:kk+50)=1;
E=ones(1,41);
for Dz=0:40

    [y, u] = p5_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz, z);
    E(Dz+1)=(yzad-y')'*(yzad-y');
end

figure
plot(0:40,E);

ylabel('Bład E'); xlabel('D_z'); grid on; grid minor;

title('Bład w zależności od D_z'); % Tytuł wykresu
zamien_kropki();
exportgraphics(gcf, 'Wykresy/Z5_DMC_error.pdf', 'ContentType', 'vector');