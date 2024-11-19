clear;
addpath ('D:\ SerialCommunication ') ; % add a path
addpath('Funkcje');
initSerialControl COM4 % initialise com port

wykresy_online_konfiguracja;

kk = 3000;

Tpp = 000; % TODO Tu uzupełnić Tpp z zad 1

% TODO
% sprawdzić czy długości są dobre, na oko powinny się zgadzać
% pytanie jak będą działać z tą nieliniowością, 
% a krótsze wykresy będą czytelniejsze
yzad(1:300) = Tpp; yzad(301:600) = Tpp+5; 
yzad(601:900) = Tpp+15; yzad(901:kk) = Tpp;

umin = 0; umax=100;

% nastawy PID są takie jak najlepsze z lab 1
K = 11;
Ti = 80;
Td = 0.3;
[r2, r1, r0] = pid_offline(K,Ti,Td,1);

% inicjlizacja
u(1:kk)=0; y(1:kk)=0; e(1:kk)=0;

% warunki początkowe
u(1:2)=25; y(1:2)=32.68; % TODO zaktualizować pp


% główna pętla symulacyjna
for k=3:kk
    % symulacja obiektu
    y(k) = readMeasurements(1);

    % uchyb regulacji
    e(k)=yzad(k)-y(k);

    % sygnał sterujący regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);

    if u(k) < umin
        u(k) = umin;
    elseif u(k) > umax
        u(k) = umax;
    end

    sendControls (1, 50) ; % W1
    sendNonlinearControls(int64(u(k))); % G1

    % aktualizacja wykresu
    wykresy_online_aktualizacja;

    waitForNewIteration () ; % wait for new iteration
end