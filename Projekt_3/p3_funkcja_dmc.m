function [y, u] = p3_funkcja_dmc(kk, yzad, N, Nu, D, lambda)

% Wartości ograniczeń
umin = -1; umax=1;

% Odpowiedź skokowa zdyskretyzowanego systemu
ys = p3_odpowiedz_skokowa(D, 0, 0.1);

[ke,ku] = DMC_offline(ys, N, Nu, lambda, D);

% Inicjalizacja
u(1:kk)=0; y(1:kk)=0; e(1:kk)=0;

% Warunki początkowe
u(1:6)=0; y(1:6)=0;
delta_u_p(1:D-1)=0; % Przeszłe przyrosty u

% Główna pętla symulacyjna
for k=7:kk
    % Symulacja obiektu
    y(k)=symulacja_obiektu15y_p3(u(k-5), u(k-6), y(k-1), y(k-2));

    % Uchyb regulacji
    e(k)=yzad(k)-y(k);

    % Obliczenie przyrostu sygnału sterującego DMC
    delta_u = ke * e(k) - ku * delta_u_p';

    % Ograniczenia wartości sygnału sterującego
    if u(k-1)+delta_u < umin
        delta_u = umin-u(k-1);
    elseif u(k-1)+delta_u > umax
        delta_u = umax-u(k-1);
    end

    % Aktualizacja sygnału sterującego
    u(k)=u(k-1)+delta_u;

    % Aktualizacja przeszłych przyrostów sterowania
    for n=D-1:-1:2
        delta_u_p(n) = delta_u_p(n-1);
    end
    delta_u_p(1) = delta_u;
end

end

