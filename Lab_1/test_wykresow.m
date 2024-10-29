% Inicjalizacja wektorów pomiarowych
data1 = [];  % Pomiary do pierwszej figury
data2 = [];  % Pomiary do drugiej figury
data3 = [];  % Pomiary do drugiej figury

% konfiguracja wykresu
figure('Position', [100, 100, 800, 600]); % Tworzenie większej figury

% Pierwszy subplot dla wykresu 'u'
subplot(2, 1, 1); % Dwa wiersze, jedna kolumna, pierwszy subplot
h1 = plot(nan, nan, 'DisplayName', 'u'); % Wykres dla pomiaru 1
xlabel('Czas (s)');
ylabel('u');
title('u');
legend('show');

% Drugi subplot dla wykresów 'y' i 'y_zad'
subplot(2, 1, 2); % Dwa wiersze, jedna kolumna, drugi subplot
h2 = plot(nan, nan, 'DisplayName', 'y'); % Wykres dla pomiaru 2
hold on;
h3 = plot(nan, nan, 'DisplayName', 'y_zad'); % Wykres dla pomiaru 3
xlabel('Czas (s)');
ylabel('y');
title('y i y_zad');
legend('show');

% Pętla, która generuje nowe wartości co 1 sekundę
for t = 1:100
    % Generowanie nowych losowych wartości dla wektorów pomiarów
    new_value1 = rand();  % Pomiary 1 (losowe wartości między 0 a 1)
    new_value2 = rand();  % Pomiary 2 (losowe wartości między 0 a 1)
    new_value3 = rand();  % Pomiary 3 (losowe wartości między 0 a 1)
    
    % Dodawanie nowych wartości do odpowiednich wektorów
    data1 = [data1, new_value1];
    data2 = [data2, new_value2];
    data3 = [data3, new_value3];
    
    % Aktualizacja wykresu
    set(h1, 'YData', data1, 'XData', 1:t);
    set(h2, 'YData', data2, 'XData', 1:t);
    set(h3, 'YData', data3, 'XData', 1:t);
        
    % Odświeżanie wykresów
    drawnow;
    
    % Pauza na 1 sekundę
    pause(1);
end
