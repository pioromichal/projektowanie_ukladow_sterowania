%% Generowanie wykresów dla regulatorów lokalnych z podziałem na PID i DMC

liczba_regulatorow = [2, 3, 4, 5]; % Liczba regulatorów lokalnych

for i = 1:length(liczba_regulatorow)
    n = liczba_regulatorow(i);
    
    % Tworzenie nowego okna wykresu
    figure;

    % PID
    subplot(2, 1, 1); % Lewy subplot dla PID
    switch n
        case 2
            centra_rozmycia = [0.00 4.00];
        case 3
            centra_rozmycia = [0, 3, 6];
        case 4
            centra_rozmycia = [-0.30  1.00  4.00  8.00];
        case 5
            centra_rozmycia = [0.00  2.00  4.00  8.00 10.00];
    end
    z_switch = 1.00;
    p5_funkcje_przynaleznosci(centra_rozmycia, z_switch);
    title(['PID - ', num2str(n), ' regulatory lokalne']);

    % DMC
    subplot(2, 1, 2); % Prawy subplot dla DMC
    switch n
        case 2
            centra_rozmycia = [0, 1];
        case 3
            centra_rozmycia = [0, 1, 8];
        case 4
            centra_rozmycia = [0, 2, 4, 8];
        case 5
            centra_rozmycia = [0, 1, 2, 4, 6];
    end
    z_switch = 1.00;
    if n == 4
        z_switch = 2.00;
    end
    p5_funkcje_przynaleznosci(centra_rozmycia, z_switch);
    title(['DMC - ', num2str(n), ' regulatory lokalne']);

    % Eksport wykresu do pliku PDF
    exportgraphics(gcf, ['Wykresy/f_przynaleznosci/', num2str(n), '_subplots.pdf'], 'ContentType', 'vector');
    close;
end
