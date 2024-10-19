function [y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda)
%P4_FUNKCJA_DMC Summary of this function goes here
%   Detailed explanation goes here

% kk=200; % koniec symulacji
dumax = 0.05;
umin = 0.3; umax=0.7;

% Odpowiedź skokowa zdyskretyzowanego systemu
ys = p3_odpowiedz_skokowa(150);

% Parametry DMC
% N=20; Nu=20; D=100; lambda=100;

% Konstrukcja macierzy M
M = zeros(N,Nu);
for column=1:Nu
    M(column:N,column) = ys(1:N-column+1);
end

% Konstrukcja macierzy Mp
Mp = zeros(N,D-1);
for j = 1:D-1
    for i = 1:N
        c = min([i+j,D]);
        Mp(i,j) = ys(c) - ys(j);
    end
end

% Obliczenie macierzy sterującej K
K = (M.'*M + lambda*eye(Nu,Nu))\M.';
K1 = K(1,:);
ke = sum(K1);
ku = K1*Mp;

% Warunki początkowe
u(1:11)=0.5; y(1:11)=4; e(1:11)=0;
delta_u_p(1:D-1)=0; % Przeszłe przyrosty u
% yzad(1:9)=4; yzad(10:kk)=i_yzad;

% Główna pętla symulacyjna
for k=12:kk
    % Symulacja obiektu
    y(k) = symulacja_obiektu1y_p1(u(k-10), u(k-11), y(k-1), y(k-2));

    % Uchyb regulacji
    e(k)=yzad(k)-y(k);

    % Obliczenie przyrostu sygnału sterującego DMC
    delta_u = ke * e(k) - ku * delta_u_p';

    % Aktualizacja przeszłych przyrostów sterowania
    for n=D-1:-1:2
        delta_u_p(n) = delta_u_p(n-1);
    end
    delta_u_p(1) = delta_u;

    % Ograniczenia przyrostu
    if  delta_u < -dumax
        delta_u = -dumax;
        % disp(['-du ' num2str(k)]);
    elseif delta_u > dumax
        delta_u = dumax;
        % disp(['du ' num2str(k)]);
    end

    % Aktualizacja sygnału sterującego
    u(k)=u(k-1)+delta_u;

    % Ograniczenia
    if u(k) < umin
        u(k) = umin;
        % disp(['umin ' num2str(k)]);
    elseif u(k) > umax
        u(k) = umax;
        % disp(['umax ' num2str(k)]);
    end
end

end

