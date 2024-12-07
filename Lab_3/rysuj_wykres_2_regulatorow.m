function [e1, e2] = rysuj_wykres_2_regulatorow(plik1, plik2, nazwa1, nazwa2)
    % Załaduj dane z plików .mat
    data1 = load(plik1);
    data2 = load(plik2);

    % Definicja wartości referencyjnych
    kk = 1200;
    Tpp = 36;
    yzad = zeros(1, kk);
    yzad(1:300) = Tpp; 
    yzad(301:600) = Tpp + 5; 
    yzad(601:900) = Tpp + 15; 
    yzad(901:kk) = Tpp;

    % Zakładając, że w plikach znajdują się zmienne 'u' i 'y' dla każdego regulatora
    u1 = data1.u(1:kk); % Przycinanie sterowania dla regulatora 1
    y1 = data1.y(1:kk); % Przycinanie wyjścia dla regulatora 1
    u2 = data2.u(1:kk); % Przycinanie sterowania dla regulatora 2
    y2 = data2.y(1:kk); % Przycinanie wyjścia dla regulatora 2

    % Obliczanie błędów względem yzad
    e1 = sum(y1(101:kk) - yzad(101:kk)); % Błąd dla regulatora 1
    e2 = sum(y2(101:kk) - yzad(101:kk)); % Błąd dla regulatora 2

    % Tworzenie wykresu z dwoma sub-plotami
    figure;

    % Subplot 1: Sterowanie
    subplot(2, 1, 1);
    plot(u1, '--', 'DisplayName', nazwa1); hold on;
    plot(u2, '-', 'DisplayName', nazwa2);
    xlabel('Czas [s]');
    ylabel('u');
    title('Sterowanie u');
    legend('show', 'Location','northwest');
    grid on;

    % Subplot 2: Wyjście
    subplot(2, 1, 2);
    plot(y1, '--', 'DisplayName', nazwa1); hold on;
    plot(y2, '-', 'DisplayName', nazwa2);
    plot(yzad, 'k-.', 'DisplayName', 'yzad'); % Dodanie yzad do wykresu wyjścia
    xlabel('Czas [s]');
    ylabel('y');
    title('Wyjście y');
    legend('show', 'Location','northwest');
    grid on;
    
    % Zapisz całą figurę jako jeden plik PDF
    exportgraphics(gcf, ['Wykresy/por_', nazwa1, '_', nazwa2, '.pdf'], 'ContentType', 'vector');
end
