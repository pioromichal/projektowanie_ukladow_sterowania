clear; close all;
kk=200;
Tp=0.5;
time=0:Tp:Tp*(kk-1);
[y,u] = p3_odpowiedz_skokowa_u(kk);

% Wykres z użyciem stairs dla y
figure; 
stairs(time, y); % Wykres z uwzględnieniem czasu

% Etykiety osi
ylabel('y'); % Etykieta osi Y
xlabel('t [s]'); % Etykieta osi X
title('Sygnał wyjściowy'); % Tytuł wykresu

grid on; 
grid minor;

% Zmień kropki na przecinki na osiach
% zamien_kropki(); 
% 
% % Eksport do PDF
% exportgraphics(gcf, 'rysunki/projekt/Zad3/odp_jednostkowa.pdf', 'ContentType', 'vector');
% close;