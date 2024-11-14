clear; close all;

y(1:7)=0;
kk=1200; % koniec symulacji
Tp=0.5; u(1:kk)=0;
time=0:Tp:Tp*(kk-1);

z(1:50)=0; z(51:250)=0.2; z(251:450)=0.4; z(451:650)=0.6;
z(651:850)=1; z(851:1050)=1.4; z(1051:1200)=0.8;
% główna pętla symulacyjna
for k=8:kk 
    % symulacja obiektu
    y(k) = symulacja_obiektu15y_p2(u(k-6), u(k-7), ...
        z(k-3), z(k-4), y(k-1), y(k-2));
end

figure;

% Tytuł główny
% sgtitle('Wyniki symulacji', 'FontSize', 14); % Główny tytuł nad oboma wykresami

% Pierwszy wykres
subplot(2, 1, 1); % 2 wiersze, 1 kolumna, pierwszy wykres
stairs(time, z); % Użycie zmiennej time
ylabel('z'); 
xlabel('t [s]'); 
grid on; 
grid minor;
title('Sygnał zakłócający', 'FontSize', 12); % Mały tytuł dla pierwszego wykresu
zamien_kropki(); 

% Drugi wykres
subplot(2, 1, 2); % 2 wiersze, 1 kolumna, drugi wykres
stairs(time, y); % Użycie zmiennej time
xlabel('t [s]'); 
ylabel('y'); 
grid on; 
grid minor;
title('Sygnał wyjściowy', 'FontSize', 12); % Mały tytuł dla drugiego wykresu
zamien_kropki(); 

% Zapis wykresu jako plik PDF
exportgraphics(gcf, 'wykresy/z2_odp_skokowe_z.pdf', 'ContentType', 'vector');
close;

% K = 1.1