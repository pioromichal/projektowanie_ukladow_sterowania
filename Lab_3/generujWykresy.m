function generujWykresy(nazwy_pliki_txt, legenda, nazwa_pliku_wykres, tk, legenda_lokalizacja_u, legenda_lokalizacja_y, varargin)
    set(0, 'DefaultAxesFontName', 'Arial');
    set(0, 'DefaultTextFontName', 'Arial');
    
    % Sprawdzenie liczby nazw plików
    if length(nazwy_pliki_txt) ~= length(legenda)
        error('Liczba nazw plików i wpisów w legendzie musi być taka sama.');
    end

    % Sprawdzenie, czy podano y_zad w pozostałych varargin
    if ~isempty(varargin) && ~isempty(varargin{1})
        y_zad = varargin{1}; % Zakładamy, że podano wartość stałą dla y_zad
    else
        y_zad = []; % Brak sygnału y_zad
    end

    % Tworzenie figure
    figure;

    % Tablica stylów linii
    LineStyles = {'-', '--', '-.', ':'}; % Można dodać więcej stylów

    % Przetwarzanie każdego pliku
    t_max = 0; % Do przechowywania maksymalnego czasu
    for i = 1:length(nazwy_pliki_txt)
        % Tworzenie nazw plików u i y
        nazwaPlikuU = [nazwy_pliki_txt{i}, '_u.txt'];
        nazwaPlikuY = [nazwy_pliki_txt{i}, '_y.txt'];

        % Wczytanie danych
        u = load(nazwaPlikuU);
        y = load(nazwaPlikuY);
        
        % Przycinanie danych
        idx_start = find(u ~= 0, 1);
        idx_start = max(1, idx_start - 10); % Uwzględnienie marginesu przed pierwszym u ≠ 0
        u = u(idx_start:end); % Przycinanie u
        y = y(idx_start:end); % Przycinanie y

        % Ograniczenie danych do tk próbek
        if length(u) > tk
            u = u(1:tk);
            y = y(1:tk);
        end

        % Tworzenie osi czasu
        t = 0:length(u)-1;
        t = t / 10;

        % Aktualizacja maksymalnego czasu
        t_max = max(t_max, t(end));

        % Wybór stylu linii
        lineStyle = LineStyles{mod(i-1, length(LineStyles)) + 1};

        % Wykres sygnału wejściowego
        subplot(2, 1, 1); % Pierwszy subplot
        plot(t, u, 'LineStyle', lineStyle, 'DisplayName', legenda{i}); % Wykres wejścia
        hold on;
        xlabel('Czas [s]');
        ylabel('Wejście u');
        title('Wejście u');
        grid on; grid minor;

        % Wykres sygnału wyjściowego
        subplot(2, 1, 2); % Drugi subplot
        plot(t, y, 'LineStyle', lineStyle, 'DisplayName', legenda{i}); % Wykres wyjścia
        hold on;
        xlabel('Czas [s]');
        ylabel('Wyjście y');
        title('Wyjście y');
        grid on; grid minor;
    end

    % Dodanie sygnału y_zad (jeśli istnieje)
    if ~isempty(y_zad)
        subplot(2, 1, 2);
        t_zad = linspace(0, t_max, 1000); % Równomierny rozkład w czasie
        
        % Tworzenie wektora y_zad, gdzie pierwsze 10 wartości to 0
        y_zad_line = [zeros(1, 10), y_zad * ones(1, 1000 - 10)]; 
        
        % Dopasowanie długości y_zad_line do t_zad
        if length(y_zad_line) < length(t_zad)
            y_zad_line = [y_zad_line, y_zad * ones(1, length(t_zad) - length(y_zad_line))];
        elseif length(y_zad_line) > length(t_zad)
            y_zad_line = y_zad_line(1:length(t_zad));
        end
        
        % Rysowanie linii przerywanej dla y_zad
        plot(t_zad, y_zad_line, 'LineStyle', '--', 'Color', [0.5, 0.5, 0.5], 'DisplayName', 'y_{zad}'); 
    end

    % Dodanie legendy z różnymi lokalizacjami
    subplot(2, 1, 1);
    legend('show', 'Location', legenda_lokalizacja_u);
    subplot(2, 1, 2);
    legend('show', 'Location', legenda_lokalizacja_y);

    % Tworzenie ścieżki zapisu
    if ~exist('wykresy', 'dir')
        mkdir('wykresy'); % Tworzy folder, jeśli nie istnieje
    end
    sciezkaZapisu = fullfile('wykresy', [nazwa_pliku_wykres, '.pdf']);

    % Zapis wykresu
    exportgraphics(gcf, sciezkaZapisu, 'ContentType', 'vector');
    disp(['Wykres zapisany w ', sciezkaZapisu]);
end
