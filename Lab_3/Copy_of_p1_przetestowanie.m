clear T1;

addpath ('D:\SerialCommunication') ; % add a path
initSerialControl COM4 % initialise com port

% konfiguracja wykresu
figure(1);
h1 = stairs(nan, nan, 'r', 'DisplayName', 'Pomiary 1'); % Wykres dla pomiaru 1
xlabel('Czas (s)');
ylabel('Wartości pomiarów');
title('Pomiar 1');
legend('show');
T1 = [];
u(1:100)=20;
u(101:400)=30;
u(401:700)=40;
u(701:1000)=50;
u(1001:1300)=60;
u(1301:1600)=70;
u(1601:1900)=80;

for t = 1:2000
    %obtaining measurements
    measurements = readMeasurements (1) ; % read measurements T1
    T1(t) = measurements;
    % processing of the measurements
    disp ( measurements ) ; % process measurements

    %sending new values of control signals
    sendControls (1,50) ; % W1 - cecha otoczenia

    % TODO
    % Uzyskać T1 dla G1=25
    % Potem wyznaczyć statykę dla G1 20...80 co 10
    sendNonlinearControls(u(t)); % G1

    % aktualizacja wykresu
    set(h1, 'YData', T1, 'XData', 1:t);
    drawnow;

    % synchronising with the control process
    waitForNewIteration () ; % wait for new iteration
end