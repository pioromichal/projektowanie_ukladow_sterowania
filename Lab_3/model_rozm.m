function y = model_rozm(kk, y_rozm, y_switch)
    % Parametry
    K = [0.44229; 0.32123; 0.22986];
    Td = 7;
    T1 = [10.2021; 6.8717; 15.3719];
    T2 = [76.437; 110.917; 77.9063];

    % Wyliczenie współczynników
    alfa1 = exp(-1 ./ T1);
    alfa2 = exp(-1 ./ T2);

    a1 = -alfa1 - alfa2;  % Wektor współczynników a1
    a2 = alfa1 .* alfa2;  % Wektor współczynników a2

    b1 = (K ./ (T1 - T2)) .* (T1 .* (1 - alfa1) - T2 .* (1 - alfa2));  % Wektor b1
    b2 = (K ./ (T1 - T2)) .* (alfa1 .* T2 .* (1 - alfa2) - alfa2 .* T1 .* (1 - alfa1));  % Wektor b2

    % Inicjalizacja sygnału wejściowego
    u = zeros(kk + Td + 3, 1);  % Sygnał wejściowy (wektor)
    u(Td + 3:end) = 1;          % Jedynki po czasie opóźnienia Td

    % Inicjalizacja wyjścia
    y = zeros(kk + Td + 3,1);  % Macierz wyników (kolumny odpowiadają modelom)

    % Symulacja
    for k = 3 + Td:kk + Td + 3
        przyn = fun_przyn_trap(y(k - 1, :), y_rozm, y_switch);  % Wektor przynależności
        y(k) = przyn * (b1 * u(k - Td - 1) + b2 * u(k - Td - 2) - a1 * y(k - 1) - a2 * y(k - 2));
    end

    % Usunięcie wartości początkowych związanych z opóźnieniem
    y = y(Td + 4:end, :);  % Zwrot wartości od czasu rzeczywistego
end
