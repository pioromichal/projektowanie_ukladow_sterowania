addpath ('D:\ SerialCommunication ') ; % add a path
initSerialControl COM6 % initialise com port

% konfiguracja wykresu
figure(1);
h1 = plot(nan, nan, 'r', 'DisplayName', 'Pomiary 1'); % Wykres dla pomiaru 1
xlabel('Czas (s)');
ylabel('Wartości pomiarów');
title('Pomiar 1');
legend('show');

for t = 1:1000
    %obtaining measurements
    measurements = readMeasurements (1) ; % read measurements T1

    % processing of the measurements
    disp ( measurements ) ; % process measurements

    %sending new values of control signals
    sendControls ([ 1 , 5 ] , [ 50 , 27 ]) ; % kolejno W1 i G1

    % aktualizacja wykresu
    set(h1, 'YData', data1, 'XData', 1:t);
    drawnow;

    % synchronising with the control process
    waitForNewIteration () ; % wait for new iteration
end