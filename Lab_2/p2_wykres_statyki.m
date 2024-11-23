
x = [10,20,30];
y = [36.68, 38.43, 40.68]; % tu uzupełnić


figure;
plot(x,y,'-*');
xlabel('Sygnał zakłócający');
ylabel('Sygnal wyjściowy');
% title('Charakterystyka statyczna w torze zakłócenia');
grid on;
exportgraphics(gca, 'Wykresy/char_stat_zaklocen.pdf', 'ContentType', 'vector');
% close;