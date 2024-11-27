% konfiguracja wykresu
figure('Position', [100, 100, 800, 600]); % Tworzenie większej figury

% Pierwszy subplot dla wykresu 'u'
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