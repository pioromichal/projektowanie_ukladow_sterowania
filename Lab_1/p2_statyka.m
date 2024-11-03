set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');

d = odczyt_danych_z_txt("pomiary/skok_1_30.txt");
c = odczyt_danych_z_txt("pomiary/skok_3_35.txt");
b = odczyt_danych_z_txt("pomiary/skok_2_40.txt");
a = odczyt_danych_z_txt("pomiary/skok_4_45.txt");
figure
stairs(a); hold on;
stairs(b);
stairs(c);
stairs(d);
xlim([0,500]);
xlabel('Czas [s]');
ylabel('Sygnal wyjściowy');
legend('y: u=45', 'y: u=40', 'y: u=35', 'y: u=30', 'Location', 'northwest');
title('Odpowiedzi skokowe obiektu');
grid on;
exportgraphics(gca, 'pomiary/odp_skok.pdf', 'ContentType', 'vector');
% close;

%ch-ka statyczna obiektu
figure;
plot([25,30,35,40,45],[32.68,34.56,36.5,38.1,40],'-*');
xlabel('Sygnał sterujący');
ylabel('Sygnal wyjściowy');
title('Charakterystyka statyczna obiektu');
grid on;
exportgraphics(gca, 'pomiary/char_stat.pdf', 'ContentType', 'vector');
% close;