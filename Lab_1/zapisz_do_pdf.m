function zapisz_do_pdf(nazwaPliku, UorY, yzad1, yzad2)
    % UorY == 0 ---> wykres u, bez yzad
    % UorY == 1 ---> wykres y, z yzad (podawana jako 3 i 4 argument, jak
    % robicie tylko u to mozna dac cokolwiek

    dane = load(nazwaPliku);

    t = dane(:, 1);
    sygnal = dane(:, 2);

    if UorY == 0
        % Wykres u
        figure;
        plot(t, sygnal);
        xlabel('Czas [s]');
        ylabel('Sygnal sterujacy');
        title('Wykres sygnalu sterujacego');
        grid on;
        axis tight;
    elseif UorY == 1
        figure;
        yzad = [yzad1*ones(450), yzad2*ones(450)];
        plot(t, sygnal, t, yzad);
        xlabel('Czas [s]');
        ylabel('Sygnal wyjsciowy, zadany');
        legend('y', 'y_{zad}', 'Location','northeast')
        title('Wykres sygnalu wyjsciowego');
        grid on;
        axis tight;
    end


    % Zapisanie wykresu do pliku PDF bez marginesów
    nazwaPDF = strcat(nazwaPliku(1:end-4), '.pdf');
    exportgraphics(gca, nazwaPDF, 'ContentType', 'vector');

    close;
end
