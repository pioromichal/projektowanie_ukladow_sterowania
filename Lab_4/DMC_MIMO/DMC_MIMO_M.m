function [M] = DMC_MIMO_M(S, N, Nu)
    [ny, nu, ~] = size(S); % Rozmiary: liczba wyjść, wejść, długość odpowiedzi
    M = zeros(ny * N, nu * Nu); % Inicjalizacja macierzy M

    % Budowa macierzy M
    for i = 1:N
        for j = 1:Nu
            if i >= j
                % Wyciągnięcie odpowiedniego fragmentu odpowiedzi skokowej
                Sp = S(:, :, i-j+1);
            else
                continue;
            end
            % Wstawienie bloku do macierzy M
            M((i-1)*ny+1:i*ny, (j-1)*nu+1:j*nu) = Sp;
        end
    end
end
