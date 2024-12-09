% konfiguracja wykresu
figure('Position', [100, 100, 800, 600]); % Tworzenie większej figury

% Pierwszy subplot dla wykresu 'u'
subplot(2, 1, 1); hold on; grid on; grid minor;
hG1 = stairs(nan, nan, 'DisplayName', 'G1');
hG2 = stairs(nan, nan, 'DisplayName', 'G2');
xlabel('Czas (s)');
ylabel('u');
title('u');
legend('show', Location='best');
% Drugi subplot dla wykresów 'y' i 'y_zad'
subplot(2, 1, 2); hold on; grid on; grid minor;
hT1 = stairs(nan, nan, 'DisplayName', 'T1');
hT3 = stairs(nan, nan, 'DisplayName', 'T3'); 
hTzad = stairs(nan, nan, 'DisplayName', 'y_{zad}'); 
xlabel('Czas (s)');
ylabel('y');
title('y i y_{zad}');
legend('show', Location='best');