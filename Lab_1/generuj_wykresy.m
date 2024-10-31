set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');

zapisz_do_pdf('pomiary/dmc1u_prep.txt', 0, 35, 40);
zapisz_do_pdf('pomiary/dmc2u_prep.txt', 0, 35, 40);
zapisz_do_pdf('pomiary/dmc2y_prep.txt', 1, 35, 40);
zapisz_do_pdf('pomiary/dmc1y_prep.txt', 1, 35, 40);

zapisz_do_pdf('pomiary/pid1u_prep.txt', 0, 35, 40);
zapisz_do_pdf('pomiary/pid2u_prep.txt', 0, 35, 40);
zapisz_do_pdf('pomiary/pid2y_prep.txt', 1, 35, 40);
zapisz_do_pdf('pomiary/pid1y_prep.txt', 1, 35, 40);

% zapisz_do_pdf('pomiary/skok_1_30.txt', 1, 0, 0);
% zapisz_do_pdf('pomiary/skok_2_40.txt', 1, 0, 0);
% zapisz_do_pdf('pomiary/skok_3_35.txt', 1, 0, 0);
% zapisz_do_pdf('pomiary/skok_4_45.txt', 1, 0, 0);
p2_statyka;

figure;
stairs(odczyt_danych_z_txt("pomiary/test_1.txt"));
xlabel('Czas [s]');
ylabel('Sygnał wyjściowy');
title('Wyznaczenie wartości wyjścia w punkcie pracy');
grid on;
exportgraphics(gca, 'pomiary/test.pdf', 'ContentType', 'vector');
close;


ymierz = odczyt_danych_z_txt("pomiary/skok_3_35.txt");
ymierz = (ymierz-32.68)/10;
ys = odp_jedn(length(ymierz));
figure;
stairs(ymierz);
hold on;
plot(ys,'--');
xlabel('Czas [s]');
ylabel('Sygnal wyjściowy');
legend('y: obiekt', 'y: model', 'Location', 'northwest')
title('Znormalizowana odpowiedź skokowa');
grid on;
exportgraphics(gca, 'pomiary/aproks.pdf', 'ContentType', 'vector');
close;