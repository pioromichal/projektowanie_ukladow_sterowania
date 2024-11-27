function [second_column] = odczyt_danych_z_txt(filename)
%ODCZYT_DANYCH_Z_TXT Summary of this function goes here
%   Detailed explanation goes here

% Odczyt danych z pliku (automatyczne rozpoznanie separatora)
data = readmatrix(filename);

% Odczyt drugiej kolumny
second_column = data(:, 2);
end

