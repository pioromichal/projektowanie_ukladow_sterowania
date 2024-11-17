function [y, u, z_pom] = p7_funkcja_dmc(kk, yzad, N, Nu, D, lambda, Dz, z, szum_val)
k_shift=7;
kk=kk+k_shift;
% Odpowiedź skokowa zdyskretyzowanego systemu
ys = p3_odpowiedz_skokowa_u(D);
yz = p3_odpowiedz_skokowa_z(Dz);

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

% Konstrukcja macierzy Mpz
Mpz = zeros(N,Dz-1);
Mpz(:,1)=yz(1:N);
for j = 2:Dz
    for i = 1:N
        c = min([i+j-1,Dz]);
        Mpz(i,j) = yz(c) - yz(j-1);
    end
end

% Obliczenie macierzy sterującej K
K = (M.'*M + lambda*eye(Nu,Nu))\M.';
K1 = K(1,:);
ke = sum(K1);
ku = K1*Mp;
kz = K(1, :) * Mpz;

% Warunki początkowe
u(1:7)=0; y(1:7)=0; z(1:7)=0;
delta_u_p(1:D-1)=0; % Przeszłe przyrosty u
delta_z_p(1:Dz)=0; % Przeszłe przyrosty z
yzad = yzad*ones(kk,1);
% Dodanie szumu do pomiaru z
z_pom=z;
for i=1:kk
    z_pom(i)=z_pom(i) + szum_val*(2*rand-1);
end

% Główna pętla symulacyjna
for k=k_shift+1:kk
    % Symulacja obiektu
    y(k) = symulacja_obiektu15y_p2(u(k-6), u(k-7), z(k-3), z(k-4), y(k-1), y(k-2));

    % Uchyb regulacji
    e(k)=yzad(k)-y(k);
    disp(k);

    % Zmiana zakłócenia    
    delta_z_p(1) = z_pom(k) - z_pom(k-1);

    % Obliczenie przyrostu sygnału sterującego DMC
    delta_u = ke * e(k) - ku * delta_u_p' - kz * delta_z_p';

    % Aktualizacja sygnału sterującego
    u(k)=u(k-1)+delta_u;

    % Aktualizacja przeszłych przyrostów sterowania
    for n=D-1:-1:2
        delta_u_p(n) = delta_u_p(n-1);
    end

    % Aktualizacja przeszłych przyrostów zakłócenia
    for m=Dz-1:-1:2
        delta_z_p(m) = delta_z_p(m-1);
    end
    delta_u_p(1) = delta_u;
end
y(1:k_shift)=[]; u(1:k_shift)=[]; z_pom(1:k_shift)=[];
end

