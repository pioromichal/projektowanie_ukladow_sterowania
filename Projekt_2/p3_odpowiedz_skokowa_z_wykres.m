clear; close all;
kk=160;
Tp=0.5;
time=Tp:Tp:Tp*kk;
[y,z] = p3_odpowiedz_skokowa_z(kk);

% Wykres z użyciem stairs dla y
figure; 
stairs(time, y, 'o', 'MarkerSize', 1.5, 'MarkerFaceColor', 'auto'); % Wykres z uwzględnieniem czasu

% Etykiety osi
ylabel('y'); % Etykieta osi Y
xlabel('t [s]'); % Etykieta osi X
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
grid on; 
grid minor;

 
% Eksport do PDF
exportgraphics(gcf, 'Wykresy/z3_odp_jednostkowa_z.pdf', 'ContentType', 'vector');
close;