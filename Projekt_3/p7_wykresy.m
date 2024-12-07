clear;
kk = 600;
Tp = 0.5;
time = 0:Tp:Tp*(kk-1);
yzad(1:100) = -0.2;
yzad(101:200) = 2;
yzad(201:300) = 6;
yzad(301:400) = 11;
yzad(401:500) = 0;
yzad(501:600) = 6;

liczba_regulatorow = [2, 3, 4, 5];

% Figura dla sygnałów wejściowych (u)
figure;
for i = 1:length(liczba_regulatorow)
    n = liczba_regulatorow(i);

    % DMC
    [yd, ud, Ed] = p5_dmc_rozmyty(n);
    disp(Ed);

    % Subplot dla sygnału wejściowego
    subplot(2, 2, i);
    stairs(time, ud);
    ylabel('u');
    xlabel('t [s]');
    grid on;
    grid minor;
    title(['Wejście dla ', num2str(n), ' regulatorów lokalnych']);
end
zamien_kropki();
exportgraphics(gcf, 'Wykresy/p7_u_all.pdf', 'ContentType', 'vector');
close;

% Figura dla sygnałów wyjściowych (y)
figure;
for i = 1:length(liczba_regulatorow)
    n = liczba_regulatorow(i);

    % DMC
    [yd, ud, Ed] = p5_dmc_rozmyty(n);
    disp(Ed);

    % Subplot dla sygnału wyjściowego
    subplot(2, 2, i);
    hold on;
    stairs(time, yd);
    stairs(time, yzad(1:kk), '--');
    xlabel('t [s]');
    ylabel('y');
    grid on;
    grid minor;
    title(['Wyjście dla ', num2str(n), ' regulatorów lokalnych']);
%     legend('DMC', 'y_{zad}');
end
zamien_kropki();
exportgraphics(gcf, 'Wykresy/p7_y_all.pdf', 'ContentType', 'vector');
close;