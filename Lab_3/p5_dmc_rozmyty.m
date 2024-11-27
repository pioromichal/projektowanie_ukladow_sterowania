clear;
addpath('D:\SerialCommunication') ; % add a path
addpath('Funkcje')
addpath('funkcje_przynaleznosci');
% initSerialControl COM4 % initialise com port

wykresy_online_konfiguracja;

kk=3000; % koniec symulacji
umin = 0; umax=100;

Tpp = 35.93; % TODO Tu uzupełnić Tpp z zad 1

% TODO
% sprawdzić czy długości są dobre, na oko powinny się zgadzać
% pytanie jak będą działać z tą nieliniowością, 
% a krótsze wykresy będą czytelniejsze
yzad(1:300) = Tpp; yzad(301:600) = Tpp+5; 
yzad(601:900) = Tpp+15; yzad(901:kk) = Tpp;

% nastawy DMC są takie jak najlepsze z lab 1
D = 500;
N = D;
Nu = D;
lambda = [1,1,1];

% Odpowiedź skokowa zdyskretyzowanego systemu
% TODO uzupełnić modele lokalne
ys = dmc_odp_jednostkowa_rozm(750);

ke(3,1)=0;
ku(3,D-1)=0;
for i=1:3
    [ke(i),ku(i,:)] = DMC_offline(ys(:,i),N,Nu,lambda(i),D);
end

% punkty rozmycia
% TODO
y_rozm=[44, 48, 51.5];

% Inicjalizacja
u(1:kk)=0; y(1:kk)=0; e(1:kk)=0;
delta_u_p(1:D-1)=0; % Przeszłe przyrosty u

% Warunki początkowe
u(1)=25; y(1)=Tpp; % TODO zaktualizować pp

% Główna pętla symulacyjna
for k=2:kk
    % Symulacja obiektu
    y(k) = readMeasurements (1);

    % Uchyb regulacji
    e(k)=yzad(k)-y(k);
    
    % TODO dobrać kształt trapezu
    mi=fun_przyn_trap(y(k), y_rozm, 2);
    disp(mi);

    % Obliczenie przyrostu sygnału sterującego DMC
    delta_u = mi*(ke * e(k) - ku * delta_u_p');

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

    sendControls (1, 50) ; % W1
    sendNonlinearControls(u(k)); % G1

    wykresy_online_aktualizacja;

    waitForNewIteration () ; 
end
