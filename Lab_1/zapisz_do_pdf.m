function zapisz_do_pdf(nazwaPliku, UorY, yzad1, yzad2)
    % UorY == 0 ---> wykres u, bez yzad
    % UorY == 1 ---> wykres y, z yzad (podawana jako 3 i 4 argument, jak
    % robicie tylko u to mozna dac cokolwiek

    dane = load(nazwaPliku);

    t = dane(:, 1);
    sygnal = dane(:, 2);

    if UorY == 0
        % Wykres u
        sygnal = int64(dane(:, 2));
        figure;
        stairs(sygnal,'LineWidth', 0.6);
        xlabel('Czas [s]');
        ylabel('Sygnał sterujący');
        title('Wykres sygnału sterującego');
        grid on;
    elseif UorY == 1
        % Wykres y
        figure;
        yzad = [yzad1*ones(1, 450), yzad2*ones(1, 450)];
        stairs(t, sygnal,'LineWidth', 0.6); 
        hold on; stairs(yzad, '--','LineWidth', 0.6);
        xlabel('Czas [s]');
        ylabel('Sygnał wyjściowy, zadany');
        legend('y', 'y_{zad}', 'Location', 'northwest')
        title('Wykres sygnału wyjściowego');
        grid on;
    end

    % Zapisanie wykresu do pliku PDF bez marginesów
    nazwaPDF = strcat(nazwaPliku(1:end-4), '.pdf');
    exportgraphics(gca, nazwaPDF, 'ContentType', 'vector');

    close;
end
