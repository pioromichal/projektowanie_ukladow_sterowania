set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');
addpath("funkcje_przynaleznosci")
% Sprawdzenie punktu pracy TODO
figure;
y=load('Pomiary\z1_punkt_pracy.mat').T1+1;
stairs(y(1:450));
xlabel('Czas [s]');
ylabel('Sygnał wyjściowy');
title('Wyznaczenie wartości wyjścia w punkcie pracy');
grid on;
exportgraphics(gca, 'Wykresy/test.pdf', 'ContentType', 'vector');
close;

% Wykresy do wyznaczania charakterystykji statycznej
p2_odp_skokowe_wykres;
p2_wykres_statyki;

% Porównanie regulatorów konwencjonalnych
[epidk,edmck]=rysuj_wykres_2_regulatorow('Pomiary/z3_PID_konwencjonalny', 'Pomiary/z3_DMC_konwencjonalny', 'PID', 'DMC');

% Wykres funkcji przynależności
p4_fun_przyn_wykres;

% Strojenie PIDa TODO

% K=[9 14 14], T_i=[80 80 80], T_d=[0.3 0.3 0.3];
[~,epidr1]=rysuj_wykres_2_regulatorow('Pomiary/z3_PID_konwencjonalny', 'Pomiary/z4_PID_1_91414', 'PID rozmyty 0', 'PID rozmyty 1');

% K=[8 22 22], T_i=[90 70 70], T_d=[0.3 0.3 0.3];
[~,epidr2]=rysuj_wykres_2_regulatorow('Pomiary/z4_PID_1_91414', 'Pomiary/z4_PID_1_82222_907070', 'PID rozmyty 1', 'PID rozmyty 2');

% K=[8 30 30], T_i=[90 60 60], T_d=[0.3 0.3 0.3];
[~,epidr3]=rysuj_wykres_2_regulatorow('Pomiary/z4_PID_1_82222_907070', 'Pomiary/z4_PID_1_83030_906060', 'PID rozmyty 2', 'PID rozmyty 3');

% Porównanie rozmytego PID z konwencjonalnym DMC TODO
[~,~]=rysuj_wykres_2_regulatorow('Pomiary/z4_PID_1_83030_906060', 'Pomiary/z3_PID_konwencjonalny', 'PID rozmyty', 'PID konwencjonalny');

% Porównanie rozmytego PID z konwencjonalnym PID TODO
[~,~]=rysuj_wykres_2_regulatorow('Pomiary/z4_PID_1_83030_906060', 'Pomiary/z3_DMC_konwencjonalny', 'PID rozmyty', 'DMC konwencjonalny');

% Odpowiedzi skokowe i jednostkowe do rozmytego DMC
p5_odp_skok_i_jedn_DMC;

% Dobór lambda DMC TODO
[edmcr1,edmcr2]=rysuj_wykres_2_regulatorow('Pomiary/z5_DMC_rozmyty_2', 'Pomiary/z5_DMC_rozmyty_3_060404', 'DMC rozmyty 1', 'DMC rozmyty 2');

% Porównanie rozmytego DMC z konwencjonalnym DMC TODO
[~,~]=rysuj_wykres_2_regulatorow('Pomiary/z5_DMC_rozmyty_3_060404', 'Pomiary/z3_DMC_konwencjonalny', 'DMC rozmyty', 'DMC konwencjonalny');

% Porównanie rozmytego DMC z konwencjonalnym PID TODO
[~,~]=rysuj_wykres_2_regulatorow('Pomiary/z5_DMC_rozmyty_3_060404', 'Pomiary/z3_PID_konwencjonalny', 'DMC rozmyty', 'PID konwencjonalny');

% Porównanie rozmytego DMC z rozmytym PID TODO
[~,~]=rysuj_wykres_2_regulatorow('Pomiary/z5_DMC_rozmyty_3_060404', 'Pomiary/z4_PID_1_83030_906060', 'DMC rozmyty', 'PID rozmyty');


