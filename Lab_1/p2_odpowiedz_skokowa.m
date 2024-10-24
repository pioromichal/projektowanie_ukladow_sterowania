addpath ('D:\ SerialCommunication ') ; % add a path
initSerialControl COM6 % initialise com port

% konfiguracja wykresu
figure(1);
h1 = plot(nan, nan, 'r', 'DisplayName', 'Pomiary 1'); % Wykres dla pomiaru 1
xlabel('Czas (s)');
ylabel('Wartości pomiarów');
title('Pomiar 1');
legend('show');

fileID = fopen('Dane_1', 'w');


T1 = zeros(600,1);
G1 = 25;
% G1 = zeros(600,1);
% W1 = zeros(600,1);
i = 1;

while (1)
    %obtaining measurements
    measurements = readMeasurements(1) ; % read measurements T1
    T1(i) = measurements;

    % processing of the measurements
    disp( measurements ) ; % process measurements

    % sending new values of control signals
    sendControls([ 1 , 5 ] , [ 50 , G1 ]) ; % kolejno W1 i G1

    % aktualizacja wykresu
    set(h1, 'YData', T1(i), 'XData', 1:t);
    drawnow;

    % synchronising with the control process
    waitForNewIteration () ; % wait for new iteration
    fprintf(fileID, '%f %f\n', i-1, T1(i));
    
    i = i + 1;
end
fclose(fileID);
