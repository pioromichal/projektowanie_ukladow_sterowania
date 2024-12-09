% clear T1;
addpath ('D:\SerialCommunication') ; % add a path
initSerialControl COM4 % initialise com port

% konfiguracja wykresu
wykresy_online_konfiguracja;

T1 = 1:100;
T3 = 1:100;
k=1;
while true
    % [T1(k), T3(k)] = readMeasurements ([1, 3]);

    disp (['T1 = ', num2str(T1(k)), '    T3 = ', num2str(T3(k))]);

    % aktualizacja wykresu
    set(hT1, 'YData', T1(1:k), 'XData', 1:k);
    set(hT3, 'YData', T3(1:k), 'XData', 1:k);
    % set(h3, 'YData', yzad(1:k), 'XData', 1:k);
    drawnow;

    % synchronising with the control process
    waitForNewIteration () ; % wait for new iteration
    k = k + 1;
end