clear;
addpath("Funkcje\");
addpath("funkcje_przynaleznosci\");

kk = 600;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

yzad(1:100)=-0.2;yzad(101:200)=2;yzad(201:300)=6;yzad(301:400)=11;yzad(401:600)=0;

ilosc_modeli = 2;

if ilosc_modeli == 1
    centra_rozmycia = 1.00;
    z_switch = 1.00;
    K_values = 0.09001;
    Ti_values = 4.29786;
    Td_values = 0.11634;

    % K_dol = 0.01; K_gor = 3;
    % Ti_dol = 0.01; Ti_gor= 10;
    % Td_dol = 0; Td_gor= 1;
    % parametry_pocz = [0.05*I, 7.0*I, 2.0*I];
    % ogr_dol = [K_dol*I, Ti_dol*I, Td_dol*I];
    % ogr_gor = [K_gor*I, Ti_gor*I, Td_gor*I];

elseif ilosc_modeli == 2
    centra_rozmycia = [0.00 4.00];
    z_switch = 1.00;
    K_values = [0.19060 0.06232];
    Ti_values = [4.02327 4.31750];
    Td_values = [0.55439 0.05790];

elseif ilosc_modeli == 3
    centra_rozmycia = [0, 3, 6]; % Centra rozmycia dla każdego modelu
    z_switch = 1;
    % wyliczane z błędu kwadratowego
    K_values = [0.17832 0.10239 0.05427];
    Ti_values = [2.69015 7.84737 3.52440];
    Td_values = [0.94919 0.26134 0.07093];

    % wyliczane z błędu absolutnego
    % K_values = [0.23837 0.06119 0.05101];
    % Ti_values = [2.84432 3.84489 3.87651];
    % Td_values = [0.81036 0.76819 0.11292];

    % K_dol = 0.01; K_gor = 3;
    % Ti_dol = 0.01; Ti_gor= 10;
    % Td_dol = 0; Td_gor= 1;
    % parametry_pocz = [0.5*I, 1.0*I, 0.0*I];
    % ogr_dol = [K_dol*I, Ti_dol*I, Td_dol*I];
    % ogr_gor = [K_gor*I, Ti_gor*I, Td_gor*I];
elseif ilosc_modeli == 4
elseif ilosc_modeli == 5
end
% Walidacja ilości modeli i parametrów
if length(K_values) ~= ilosc_modeli || length(Ti_values) ~= ilosc_modeli || length(Td_values) ~= ilosc_modeli
    error('Liczba modeli i liczba parametrów nie są zgodne!');
end

% Tworzenie modeli w pętli
parametry_pid = cell(1, ilosc_modeli);
for i = 1:ilosc_modeli
    parametry_pid{i} = p5_pid_offline_rozmyty(K_values(i), Ti_values(i), Td_values(i), Tp);
end

[yp, up] = p5_funkcja_pid_rozmyty(kk, yzad, parametry_pid, centra_rozmycia, z_switch);



% Pid optymalny
% TODO wyznaczyć jakiś, teraz sa losowe XD

K = 0.09;
Ti = 7.5;
Td = 1.8;

[r2, r1, r0] = pid_offline(K,Ti,Td,0.5);
[y, u] = p3_funkcja_pid(kk, yzad, r2, r1, r0);

% wyniki symulacji
figure;
hold on; stairs(time,up);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
% legend('u: PID dostrojony', 'u: PID początkowy', 'Location','best');
title('Sygnał wejściowy'); % Tytuł wykresu
zamien_kropki();
% exportgraphics(gcf, 'Wykresy/p4_pid_u.pdf', 'ContentType', 'vector');
% close;

figure;  hold on; stairs(time,yp); stairs(time,yzad,'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
% legend('y: PID dostrojony', 'y: PID początkowy', 'y_{zad}', 'Location','best');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki();
% exportgraphics(gcf, 'Wykresy/p4_pid_y.pdf', 'ContentType', 'vector');
% close;

Ep = (yzad-yp)*(yzad-yp)';
E = (yzad-y)*(yzad-y)';
disp(Ep)


