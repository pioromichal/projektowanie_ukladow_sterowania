set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
addpath("funkcje_przynaleznosci")
% % Sprawdzenie punktu pracy TODO
% figure;
% stairs(odczyt_danych_z_txt("pomiary/test.txt"));
% xlabel('Czas [s]');
% ylabel('Sygnał wyjściowy');
% title('Wyznaczenie wartości wyjścia w punkcie pracy');
% grid on;
% exportgraphics(gca, 'Pomiary/test.pdf', 'ContentType', 'vector');
% close;
% y_vals = [44, 48, 51.5];
% yr=model_rozm(400,y_vals,2);
% 
% figure;
% plot(yr);

% Wykresy do wyznaczania charakterystykji statycznej
% p2_odp_skokowe_wykres;
% p2_wykres_statyki;

% Porównanie regulatorów konwencjonalnych
% [e1,e2]=rysuj_wykres_2_regulatorow('Pomiary/z3_PID_konwencjonalny', 'Pomiary/z3_DMC_konwencjonalny', 'PID', 'DMC');

% Wykres funkcji przynależności
% p4_fun_przyn_wykres;

% Strojenie PIDa TODO

% Porównanie rozmytego PID z konwencjonalnym DMC TODO
% [e1,e2]=rysuj_wykres_2_regulatorow('Pomiary/z4_PID_rozmyty', 'Pomiary/z3_PID_konwencjonalny', 'PID rozmyty', 'PID konwencjonalny');

% Porównanie rozmytego PID z konwencjonalnym PID TODO
% [e1,e2]=rysuj_wykres_2_regulatorow('Pomiary/z4_PID_rozmyty', 'Pomiary/z3_DMC_konwencjonalny', 'PID rozmyty', 'DMC konwencjonalny'');

% Odpowiedzi skokowe do rozmytego DMC


% Odpowiedzi jednostkowe do rozmytego DMC
% p5_odp_skok_i_jedn_DMC;

% Porównanie rozmytego DMC z konwencjonalnym DMC TODO
[e1,e2]=rysuj_wykres_2_regulatorow('Pomiary/z5_DMC_rozmyty_2', 'Pomiary/z5_DMC_rozmyty_3_060404', 'DMC 2', 'DMC 3');

% Porównanie rozmytego DMC z konwencjonalnym PID TODO
% [e1,e2]=rysuj_wykres_2_regulatorow('Pomiary/z5_DMC_rozmyty', 'Pomiary/z3_DMC_konwencjonalny', 'DMC rozmyty', 'DMC konwencjonalny');

% Porównanie rozmytego DMC z rozmytym PID TODO
% [e1,e2]=rysuj_wykres_2_regulatorow('Pomiary/z5_DMC_rozmyty', 'Pomiary/z4_PID_rozmyty', 'DMC rozmyty', 'PID rozmyty');

% Dobór lambda DMC TODO
