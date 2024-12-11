function zamien_kropki()
    yticks = get(gca, 'YTick'); % Pobierz etykiety Y
    set(gca, 'YTickLabel', strrep(cellstr(num2str(yticks(:))), '.', ',')); % Zmień kropki na przecinki

    xticks = get(gca, 'XTick'); % Pobierz etykiety X
    set(gca, 'XTickLabel', strrep(cellstr(num2str(xticks(:))), '.', ',')); % Zmień kropki na przecinki
end

% zapisze sobie tu bo ciagle gubie: set(groot, 'defaultAxesFontName', 'Arial'); 
% na polskie znaki