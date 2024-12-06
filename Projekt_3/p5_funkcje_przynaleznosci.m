% Główna funkcja do wyświetlania wykresów przynależności
function [] = p5_funkcje_przynaleznosci(z_vals, z_switch)
    addpath('funkcje_przynaleznosci\')
    numModels = length(z_vals);            % Liczba modeli lokalnych
    z_min = -2;               % Zakres minimalny wykresu
    z_max = 12;               % Zakres maksymalny wykresu
    z_range = linspace(z_min, z_max, 1000); % Przedział wartości 'z' dla wykresu

    % Tworzenie i wyświetlanie wykresów dla każdego modelu
    hold on;
    colors = lines(numModels);  % Kolory dla każdego modelu

    % Obliczanie i rysowanie funkcji przynależności dla każdego modelu
    for i = 1:numModels
        mi_values = zeros(1, length(z_range));
        for j = 1:length(z_range)
            % Obliczanie przynależności dla każdego punktu z zakresu
            mi = fun_przyn_trap(z_range(j), z_vals, z_switch);
            mi_values(j) = mi(i);
        end
        
        % Rysowanie wykresu dla modelu i (zamiana osi x i y)
        plot(z_range, mi_values, 'Color', colors(i,:), 'DisplayName', sprintf('Model %d', i), 'LineWidth', 1.5);
    end
    
    % Ustawienia wykresu
    xlabel('y');  % Zamiana oznaczeń osi
    ylabel('Przynależność');
    title('Funkcje przynależności trapezoidalne');
    legend('show', 'Location','best');
    grid on;
end
