clear; close all;
kk=200; % koniec symulacji
u(1:kk)=0; y(1:6)=0;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

% główna pętla symulacyjna
for k=7:kk 
    % symulacja obiektu
    y(k) = symulacja_obiektu15y_p3(u(k-5), u(k-6), y(k-1), y(k-2));
end

% Tworzenie figury
figure;

% % Tytuł główny
% sgtitle('Sprawdzenie poprawności punktu pracy', 'FontSize', 14); % Tytuł nad oboma wykresami

% Pierwszy wykres
subplot(2, 1, 1); % 2 wiersze, 1 kolumna, pierwszy wykres
stairs(time, u);
grid on; grid minor;
xlabel('t [s]');
ylabel('u');
title('Sygnał wejściowy', 'FontSize', 12); % Mały tytuł dla pierwszego wykresu
zamien_kropki(); 

% Drugi wykres
subplot(2, 1, 2); % 2 wiersze, 1 kolumna, drugi wykres
stairs(time, y);
grid on; grid minor;
xlabel('t [s]');
ylabel('y');
title('Sygnał wyjściowy', 'FontSize', 12); % Mały tytuł dla drugiego wykresu
zamien_kropki(); 

% Zapis wykresu jako plik PDF
exportgraphics(gcf, 'Wykresy/z1_test.pdf', 'ContentType', 'vector');
close;