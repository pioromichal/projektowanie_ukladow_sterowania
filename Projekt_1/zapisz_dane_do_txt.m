function [] = zapisz_dane_do_txt(dane, nazwa)
    fileID = fopen(nazwa, 'w');
    
    for i = 1:length(dane)
        fprintf(fileID, '%f %f\n', i-1, dane(i));
    end
    
    fclose(fileID);
end