addpath('funkcje_przynaleznosci\')

% Główna funkcja do wyświetlania wykresów przynależności
function plot_membership_functions(z_vals, z_switch, subplot_position)
    numModels = length(z_vals);            % Liczba modeli lokalnych
    z_min = -2;               % Zakres minimalny wykresu
    z_max = 12;               % Zakres maksymalny wykresu
    z_range = linspace(z_min, z_max, 1000); % Przedział wartości 'z' dla wykresu
    
    % Tworzenie i wyświetlanie wykresów dla każdego modelu
    subplot(1, 2, subplot_position); hold on;
    colors = lines(numModels);  % Kolory dla każdego modelu

    % Obliczanie i rysowanie funkcji przynależności dla każdego modelu
    for i = 1:numModels
        mi_values = zeros(1, length(z_range));
        for j = 1:length(z_range)
            % Obliczanie przynależności dla każdego punktu z zakresu
            mi = fun_przyn_trap(z_range(j), z_vals, z_switch);
            mi_values(j) = mi(i);
        end
        
        % Rysowanie wykresu dla modelu i
        plot(mi_values, z_range,'Color', colors(i,:), 'DisplayName', sprintf('Model %d', i), 'LineWidth', 1.5);
    end
    
    % Ustawienia wykresu
    xlabel('Przynależność');
    ylabel('y');
    title('Funkcje przynależności trapezoidalne');
    legend('show');
    grid on;
end

% Przykładowe użycie
z_vals = [0,2];  % Wartości centralne dla modeli lokalnych
z_switch = 1;  % Szerokość płaskiego fragmentu trapezu

% Wczytanie danych i rysowanie subplotów
load("statyka.mat");

figure;
% Lewy subplot (statyka)
subplot(1, 2, 1);
plot(us, ys, 'DisplayName', 'statyka', 'LineWidth', 1.5);
xlabel('u');
ylabel('y');
title('Statyka');
legend('show');
grid on;

% Prawy subplot (funkcje przynależności)
plot_membership_functions(z_vals, z_switch, 2);
