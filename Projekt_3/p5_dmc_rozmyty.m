clear;
addpath("Funkcje\");

kk = 600;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

yzad(1:100)=-0.2;yzad(101:200)=2;yzad(201:300)=6;yzad(301:400)=11; yzad(401:500)=0; yzad(501:600)=6;% ostatni skok nie wykorzystany

ilosc_modeli = 5;

if ilosc_modeli == 1
    N = 50;
    Nu = 50;
    D = 50;
    lambdy = 1;
    centra_rozmycia = [0];
    z_switch = 1;


elseif ilosc_modeli == 2
    N = 50;
    Nu = 50;
    D = 50;
    lambdy = [1,1];
    centra_rozmycia = [0,1];
    z_switch = 1;

elseif ilosc_modeli == 3
    N = 50;
    Nu = 50;
    D = 50;
    lambdy = [1,1,1];
    centra_rozmycia = [0,1,8];
    z_switch = 1;

elseif ilosc_modeli == 4
    N = 50;
    Nu = 50;
    D = 50;
    lambdy = [1,1,1,1];
    centra_rozmycia = [0,2,4,8];
    z_switch = 2;

elseif ilosc_modeli == 5
    N = 50;
    Nu = 50;
    D = 50;
    lambdy = [10000*ones(1,5)];
    centra_rozmycia = [0,1,2,4,6];
    z_switch = 1;


end

% Tworzenie modeli w pętli
modele = cell(1, ilosc_modeli);
for i = 1:ilosc_modeli
    modele{i} = p3_odpowiedz_skokowa(D,centra_rozmycia(i),0.1);
end

[ke_r, ku_r] = DMC_rozmyty_offline(modele, N,Nu,lambdy,D);


[y, u] = p5_funkcja_dmc_rozmyty(kk, yzad, D, centra_rozmycia, z_switch, ke_r, ku_r);



% wyniki symulacji
figure;
stairs(time,u); hold on;
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
% legend('u: DMC', 'Location','best');
title('Sygnał wejściowy'); % Tytuł wykresu
zamien_kropki();
% exportgraphics(gcf, 'Wykresy/p4_dmc_u.pdf', 'ContentType', 'vector');
% close;

figure; stairs(time,y); hold on; stairs(time,yzad(1:kk),'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: DMC', 'y_{zad}', 'Location','best');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki();
% exportgraphics(gcf, 'Wykresy/p4_dmc_y.pdf.pdf', 'ContentType', 'vector');
% close;

E = (yzad(1:kk)-y)*(yzad(1:kk)-y)';
disp(E )
