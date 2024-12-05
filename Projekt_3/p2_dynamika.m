clear; close all;

y(1:6)=0;
kk=1500; % koniec symulacji
Tp=0.5;
time=0:Tp:Tp*(kk-1);

u(1:50)=0; u(51:250)=-0.4; u(251:450)=-1; u(451:650)=-0.2;
u(651:850)=0.2; u(851:1050)=0.4; u(1051:1200)=0.6; u(1201:1350)=0.8;
u(1351:1500)=1.0;
% główna pętla symulacyjna
for k=7:kk 
    % symulacja obiektu
    y(k) = symulacja_obiektu15y_p3(u(k-5), u(k-6), y(k-1), y(k-2));
end

figure;

% Tytuł główny
% sgtitle('Wyniki symulacji', 'FontSize', 14); % Główny tytuł nad oboma wykresami

% Pierwszy wykres
subplot(2, 1, 1); % 2 wiersze, 1 kolumna, pierwszy wykres
stairs(time, u); % Użycie zmiennej time
ylabel('u'); 
xlabel('t [s]'); 
grid on; 
grid minor;
title('Sygnał wejściowy', 'FontSize', 12); % Mały tytuł dla pierwszego wykresu
% zamien_kropki(); 

% Drugi wykres
subplot(2, 1, 2); % 2 wiersze, 1 kolumna, drugi wykres
stairs(time, y); % Użycie zmiennej time
xlabel('t [s]'); 
ylabel('y'); 
grid on; 
grid minor;
title('Sygnał wyjściowy', 'FontSize', 12); % Mały tytuł dla drugiego wykresu
% zamien_kropki(); 

% Zapis wykresu jako plik PDF
exportgraphics(gcf, 'wykresy/p2_dynamika.pdf', 'ContentType', 'vector');
% close;

% K = ? bo nieliniowe 