
x = [20, 30, 40, 50, 60, 70, 80];
y = [33.50,37.68,42.12,46.50,49.18,51.31,54.00]; % tu uzupełnić


figure;
plot(x,y,'-*');
xlabel('Sygnał sterujący');
ylabel('Sygnal wyjściowy');
title('Charakterystyka statyczna nieliniowego obiektu');
grid on;
exportgraphics(gca, 'Wykresy/char_stat_niel.pdf', 'ContentType', 'vector');
% close;