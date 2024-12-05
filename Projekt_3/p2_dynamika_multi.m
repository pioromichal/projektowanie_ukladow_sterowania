clear; close all;

% Parametry symulacji
y0 = 0; % Początkowa wartość wyjściowa
kk_segment = 60+7; % Liczba próbek dla jednego skoku
Tp = 0.5;
time_segment = 0:Tp:Tp*(kk_segment-1); % Oś czasu dla jednego segmentu
u_values = [-1, 0, 0.2, 0.4, 0.6, 0.8, 1.0]; % Wartości skoków sygnału wejściowego
num_segments = length(u_values); % Liczba segmentów

% Przygotowanie danych do wykresów
time_plot = time_segment; % Wspólna oś czasu dla wszystkich segmentów
y_all = zeros(num_segments, kk_segment); % Macierz wyników y

% Symulacja dla każdego skoku
for i = 1:num_segments
    % Sygnał wejściowy dla danego segmentu
    u = zeros(1, kk_segment);
    u(7:kk_segment) = u_values(i);
    
    % Symulacja obiektu dla danego skoku
    y = zeros(1, kk_segment);
    y(1:6) = y0; % Ustawienie początkowych wartości wyjścia na 0
    for k = 7:kk_segment
        y(k) = symulacja_obiektu15y_p3(u(k-5), u(k-6), y(k-1), y(k-2));
    end
    
    % Zapis wyników
    y_all(i, :) = y; % Przechowywanie danych wyjściowych dla danego skoku
end

% Wykres wyników
figure;

% Wykres sygnału wyjściowego dla różnych skoków
hold on;
for i = 1:num_segments
    plot(time_plot(8:kk_segment)-3, y_all(i, (8:kk_segment)), 'DisplayName', sprintf('u = %.1f', u_values(i)));
end
% u = zeros(1, kk_segment);
% u(7:kk_segment) = u_values(7);
% plot(time_plot(2:kk_segment)-3, u(2:kk_segment));
hold off;

xlabel('t [s]');
ylabel('y');
title('Sygnał wyjściowy dla różnych skoków u');
legend('show', Location='best'); % Wyświetlenie legendy
grid on;
grid minor;

% Zapis wykresu jako plik PDF
exportgraphics(gcf, 'wykresy/p2_dynamika_wieloskoki.pdf', 'ContentType', 'vector');
