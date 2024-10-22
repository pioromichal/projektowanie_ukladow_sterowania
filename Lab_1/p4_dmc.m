clear;

% konfiguracja wykresu
figure(1);
h1 = plot(nan, nan, 'DisplayName', 'u'); % Wykres dla pomiaru 1
xlabel('Czas (s)');
ylabel('u');
title('u');
legend('show');
figure(2);
h2 = plot(nan, nan, 'DisplayName', 'y'); % Wykres dla pomiaru 2
hold on;
h3 = plot(nan, nan, 'DisplayName', 'y_zad'); % Wykres dla pomiaru 3
xlabel('Czas (s)');
ylabel('y');
title('y i y_zad');
legend('show');

yzad = 35;
yzad = yzad*ones(kk,1);
N = 17;
Nu = 20;
D = 80;
lambda = 5;

kk=600; % koniec symulacji
umin = 0; umax=100;

% Odpowiedź skokowa zdyskretyzowanego systemu
ys = p3_odpowiedz_skokowa(150); 

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
u(1:kk)=0; y(1:kk)=0; e(1:kk)=0;
delta_u_p(1:D-1)=0; % Przeszłe przyrosty u

% Główna pętla symulacyjna
for k=12:kk
    % Symulacja obiektu
    y(k) = readMeasurements (1);

    % Uchyb regulacji
    e(k)=yzad(k)-y(k);

    % Obliczenie przyrostu sygnału sterującego DMC
    delta_u = ke * e(k) - ku * delta_u_p';

    % Ograniczenia przyrostu
    if  delta_u < -dumax
        delta_u = -dumax;
        % disp(['-du ' num2str(k)]);
    elseif delta_u > dumax
        delta_u = dumax;
        % disp(['du ' num2str(k)]);
    end

    % Ograniczenia
    if u(k-1)+delta_u < umin
        delta_u = umin-u(k-1);
        % u(k) = umin;
        % disp(['umin ' num2str(k)]);
    elseif u(k-1)+delta_u > umax
        delta_u = umax-u(k-1);
        % u(k) = umax;
        % disp(['umax ' num2str(k)]);
    end

    % Aktualizacja sygnału sterującego
    u(k)=u(k-1)+delta_u;

    % Aktualizacja przeszłych przyrostów sterowania
    for n=D-1:-1:2
        delta_u_p(n) = delta_u_p(n-1);
    end
    delta_u_p(1) = delta_u;

    sendControls ([ 1 , 5 ] , [ 50 , u(k) ]) ; % kolejno W1 i G1

    % aktualizacja wykresu
    figure(1);
    set(h1, 'YData', u, 'XData', 1:t);
    figure(2);
    set(h2, 'YData', y, 'XData', 1:t);
    set(h3, 'YData', yzad, 'XData', 1:t);

    waitForNewIteration () ; % wait for new iteration
end

% zapisywanie danych do pliku, tak aby nie nadpisywało starych pomiarow
i = 1;
while 1
    filename1 = ['pomiary/p4_dmc_' num2str(i) '_y.txt'];
    filename2 = ['pomiary/p4_dmc_' num2str(i) '_u.txt'];

    if exist(filename1, 'file') == 2 || exist(filename2, 'file') == 2
        i = i + 1;
    else
        zapisz_dane_do_txt(y, filename1);
        zapisz_dane_do_txt(u, filename2);
        break;
    end
end

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana');

E = (yzad-y')'*(yzad-y');
disp([N Nu D E])