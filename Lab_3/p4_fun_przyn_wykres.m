addpath('funkcje_przynaleznosci')

% Parametry funkcji przynależności
z_vals = [44, 48, 51.5];  % Wartości centralne (np. dla funkcji trapezowych)
z_switch = 2;  % Przełącznik szerokości strefy przejściowej (opcjonalne dopasowanie)

% Zakres wartości wejściowych
z = 30:0.1:55;  % Zmienna wejściowa z w zakresie od 20 do 60

% Oblicz przynależność dla każdej wartości z
mi = zeros(length(z), length(z_vals));  % Inicjalizacja macierzy przynależności
for i = 1:length(z)
    mi(i, :) = fun_przyn_trap(z(i), z_vals, z_switch);  % Obliczenie funkcji przynależności
end

% Rysowanie wykresu
figure;
hold on;
% Różne style linii
styles = {'-', '--', ':'};  % Styles dla różnych linii

for i = 1:length(z_vals)
    plot(z, mi(:, i), 'DisplayName', sprintf('Regulator %d', i), 'LineWidth', 2, 'LineStyle', styles{i});
end
xlabel('y');
ylabel('\mu');
title('Wykres funkcji przynależności');
legend('show', 'Location', 'northwest');
grid on;

% Zmniejszenie wysokości wykresu
set(gcf, 'Position', [100, 100, 600, 300]);  % Dostosowanie rozmiaru figury (szerokość: 600, wysokość: 300)
exportgraphics(gcf, 'Wykresy/fun_przyn.pdf', 'ContentType', 'vector');
close;