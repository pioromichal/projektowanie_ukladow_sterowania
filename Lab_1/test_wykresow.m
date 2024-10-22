% Inicjalizacja wektorów pomiarowych
data1 = [];  % Pomiary do pierwszej figury
data2 = [];  % Pomiary do drugiej figury
data3 = [];  % Pomiary do drugiej figury

% Tworzenie pierwszej figury do wykresu jednego pomiaru
figure(1);
h1 = plot(nan, nan, 'r', 'DisplayName', 'Pomiary 1'); % Wykres dla pomiaru 1
xlabel('Czas (s)');
ylabel('Wartości pomiarów');
title('Pomiar 1');
legend('show');
xlim([0 100]);
ylim([0 1]); % Zakres osi Y dostosowany do wartości losowych z funkcji rand()

% Tworzenie drugiej figury do wykresu dwóch pomiarów
figure(2);
h2 = plot(nan, nan, 'b', 'DisplayName', 'Pomiary 2'); % Wykres dla pomiaru 2
hold on;
h3 = plot(nan, nan, 'g', 'DisplayName', 'Pomiary 3'); % Wykres dla pomiaru 3
xlabel('Czas (s)');
ylabel('Wartości pomiarów');
title('Pomiary 2 i 3');
legend('show');
xlim([0 100]);
ylim([0 1]); % Zakres osi Y dostosowany do wartości losowych z funkcji rand()

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
    
    % Aktualizacja danych na pierwszym wykresie (figura 1)
    figure(1);
    set(h1, 'YData', data1, 'XData', 1:t);
    
    % Aktualizacja danych na drugim wykresie (figura 2)
    figure(2);
    set(h2, 'YData', data2, 'XData', 1:t);
    set(h3, 'YData', data3, 'XData', 1:t);
    
    % Odświeżanie wykresów
    drawnow;
    
    % Pauza na 1 sekundę
    pause(1);
end
