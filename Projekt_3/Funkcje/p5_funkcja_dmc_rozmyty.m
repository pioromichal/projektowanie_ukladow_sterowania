function [y, u] = p5_funkcja_dmc_rozmyty(kk, yzad, D, centra_rozmycia, z_switch, ke_r, ku_r)

% Wartości ograniczeń
umin = -1; umax=1;

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

    mi = fun_przyn_trap(y(k), centra_rozmycia, z_switch);

    % Obliczenie przyrostu sygnału sterującego DMC
    delta_u = 0;
    ilosc_modeli = length(ke_r);
    for i = 1:ilosc_modeli
        delta_u = delta_u + mi(i)*(ke_r(i)*e(k) - ku_r(i,:)*delta_u_p');
    end

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

