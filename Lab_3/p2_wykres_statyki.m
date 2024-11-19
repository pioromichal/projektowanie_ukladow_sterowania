
x = [20, 25, 30, 40, 50, 60, 70, 80];
y = [1,1,1,1,1,1,1,1]; % tu uzupełnić


figure;
plot(x,y,'-*');
xlabel('Sygnał sterujący');
ylabel('Sygnal wyjściowy');
title('Charakterystyka statyczna nieliniowego obiektu');
grid on;
exportgraphics(gca, 'Wykresy/char_stat_niel.pdf', 'ContentType', 'vector');
% close;