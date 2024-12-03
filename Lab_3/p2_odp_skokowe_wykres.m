% Odpowiedzi skokowe do statyki
u=odczyt_danych_z_txt("Pomiary/charakterystyka_statyczna_u.txt.txt");
y=odczyt_danych_z_txt("Pomiary/charakterystyka_statyczna_y.txt.txt");
figure;

% Ustawienie lewej osi Y
yyaxis left;
stairs(u(1:1900),'--'); % Rysowanie danych dla u
ylabel('Wejście u'); % Etykieta osi Y dla u
hold on;

% Ustawienie prawej osi Y
yyaxis right;
stairs(y(1:1900)); % Rysowanie danych dla y
ylabel('Wyjście y'); % Etykieta osi Y dla y

% Etykiety osi X
xlabel('Czas [s]');
title('Odpowiedzi skokowe');
grid on;
exportgraphics(gca, 'Wykresy/odp_skokowe_stat.pdf', 'ContentType', 'vector');
% close;