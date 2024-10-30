function zapisz_do_pdf(nazwaPliku, UorY, yzad1, yzad2)
    % UorY == 0 ---> wykres u, bez yzad
    % UorY == 1 ---> wykres y, z yzad (podawana jako 3 i 4 argument, jak
    % robicie tylko u to mozna dac cokolwiek

    dane = load(nazwaPliku);

    t = dane(:, 1);
    sygnal = int64(dane(:, 2));

    if UorY == 0
        % Wykres u
        figure;
        stairs(sygnal);
        xlabel('Czas [s]');
        ylabel('Sygnal sterujacy');
        title('Wykres sygnalu sterujacego');
        grid on;
    elseif UorY == 1
        % Wykres y
        figure;
        yzad = [yzad1*ones(450, 1), yzad2*ones(450, 1)];
        stairs(sygnal); hold on; stairs(yzad, ':');
        xlabel('Czas [s]');
        ylabel('Sygnal wyjsciowy, zadany');
        legend('y', 'y_{zad}', 'Location', 'northwest')
        title('Wykres sygnalu wyjsciowego');
        grid on;
    end

    % Zapisanie wykresu do pliku PDF bez marginesów
    nazwaPDF = strcat(nazwaPliku(1:end-4), '.pdf');
    exportgraphics(gca, nazwaPDF, 'ContentType', 'vector');

    close;
end
