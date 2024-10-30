clear; close all;

y(1:11)=2; e(1:11)=0; 
kk=900; % koniec symulacji
Tp=0.5;
time=0:Tp:Tp*(kk-1);

u(1:50)=1.2; u(51:200)=1.25; u(201:350)=1.28; u(351:500)=1.32; u(501:750)=1.27; u(751:900)=1.26;
% główna pętla symulacyjna
for k=12:kk 
    % symulacja obiektu
    y(k) = symulacja_obiektu15y_p1(u(k-10), u(k-11), y(k-1), y(k-2));
end

figure;

% Tytuł główny
sgtitle('Wyniki symulacji', 'FontSize', 14); % Główny tytuł nad oboma wykresami

% Pierwszy wykres
subplot(2, 1, 1); % 2 wiersze, 1 kolumna, pierwszy wykres
stairs(time, u); % Użycie zmiennej time
ylabel('Sygnał wejściowy (u)'); 
xlabel('Czas [s]'); 
grid on; 
grid minor;
title('Sygnał wejściowy', 'FontSize', 12); % Mały tytuł dla pierwszego wykresu
zamien_kropki(); % Ustaw etykiety osi

% Drugi wykres
subplot(2, 1, 2); % 2 wiersze, 1 kolumna, drugi wykres
stairs(time, y); % Użycie zmiennej time
xlabel('Czas [s]'); 
ylabel('Sygnał wyjściowy (y)'); 
grid on; 
grid minor;
title('Sygnał wyjściowy', 'FontSize', 12); % Mały tytuł dla drugiego wykresu
zamien_kropki(); % Ustaw etykiety osi

% Zapis wykresu jako plik PDF
exportgraphics(gcf, 'rysunki/projekt/Zad2/odp_skokowe.pdf', 'ContentType', 'vector');
close;