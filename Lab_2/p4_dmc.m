clear;
addpath ('D:\ SerialCommunication ') ; % add a path
initSerialControl COM4 % initialise com port

% Pierwszy subplot dla wykresu 'u'
figure('Position', [100, 100, 800, 600]);
subplot(2, 1, 1);
h1 = stairs(nan, nan, 'DisplayName', 'u');
xlabel('Czas (s)');
ylabel('u');
title('u');
legend('show');
% Drugi subplot dla wykresów 'y' i 'y_zad'
subplot(2, 1, 2);
h2 = stairs(nan, nan, 'DisplayName', 'y'); 
hold on;
h3 = stairs(nan, nan, 'DisplayName', 'y_zad'); 
xlabel('Czas (s)');
ylabel('y');
title('y i y_zad');
legend('show');

kk=3000; % koniec symulacji
umin = 0; umax=100;

yzad(1:450) = 35; yzad(451:900) = 40; yzad(901:kk)=33;
% N = 400;
% Nu = 3;
% D = 700;
% lambda = 0.05;
N = 200;
Nu = 5;
D = 500;
lambda = 0.2;

% Odpowiedź skokowa zdyskretyzowanego systemu
ys = odp_jedn(750);

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
Mpz = zeros(N,Dz);
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
kz = K1 * Mpz;

% Warunki początkowe
u(1:kk)=0; y(1:kk)=0; e(1:kk)=0;
u(1)=25; y(1)=32.68;
delta_u_p(1:D-1)=0; % Przeszłe przyrosty u
delta_z_p(1:Dz)=0; % Przeszłe przyrosty z

% Główna pętla symulacyjna
for k=2:kk
    % Symulacja obiektu
    y(k) = readMeasurements (1);

    % Uchyb regulacji
    e(k)=yzad(k)-y(k);

    % Obliczenie przyrostu sygnału sterującego DMC
    delta_u = ke * e(k) - ku * delta_u_p' - kz * delta_z_p';

    % Ograniczenia
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

    % Aktualizacja przeszłych przyrostów zakłócenia
    for m=Dz-1:-1:2
        delta_z_p(m) = delta_z_p(m-1);
    end
    
    sendControls (1,50) ; % W1
    sendControlsToG1AndDisturbance(int64(u(k)),0);

    % aktualizacja wykresu
    set(h1, 'YData', u(1:k), 'XData', 1:k);
    set(h2, 'YData', y(1:k), 'XData', 1:k);
    set(h3, 'YData', yzad(1:k), 'XData', 1:k);
    drawnow;

    waitForNewIteration () ; % wait for new iteration
end

% zapisywanie danych do pliku, tak aby nie nadpisywało starych pomiarow
i = 1;
while 1
    filename1 = ['p4_dmc_' num2str(i) '_y'];
    filename2 = ['p4_dmc_' num2str(i) '_u'];

    if exist(['pomiary/'  filename1  '.txt'], 'file') == 2 || exist(['pomiary/'  filename2  '.txt'], 'file') == 2
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