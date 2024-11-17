clear all; close all;
% koniec symulacji
kk = 500;

% Tworzenie macierzy do przechowywania wartości y
% dla każdej kombinacji (u, z)
us = 0:0.05:1;
zs = 0:0.05:1;
ys = zeros(length(us), length(zs));

for i = 1:length(us)
    for j = 1:length(zs)
        u(1:kk) = us(i);
        z(1:kk) = zs(j);

        % resetowanie historii wyjścia y
        y(1:7) = 0;

        % główna pętla symulacyjna
        for k = 8:kk
            y(k) = symulacja_obiektu15y_p2(u(k-6), u(k-7), ...
                z(k-3), z(k-4), y(k-1), y(k-2));
        end

        % zapisanie y dla danej kombinacji (u, z)
        ys(i, j) = y(kk);
    end
end

% tworzenie siatki współrzędnych dla u i z
[U, Z] = meshgrid(us, zs);

% tworzenie wykresu 3D
figure;
surf(U, Z, ys', 'FaceAlpha', 0.8); hold on; 
mesh(U, Z, ys');    % dodanie siatki 3D
colorbar;
view(3);
title('Charakterystyka statyczna');
xlabel('u');
ylabel('z');
zlabel('y');
grid on;
grid minor;
shading interp;
exportgraphics(gcf, 'Wykresy/Z2_statyka.pdf', 'ContentType', 'image');
close;