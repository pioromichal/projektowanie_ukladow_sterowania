set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');


dane1 = load('pomiary/odpowiedz_skokowa_z10.txt');
dane2 = load('pomiary/odpowiedz_skokowa_z20.txt');
dane3 = load('pomiary/odpowiedz_skokowa_z30.txt');

t1 = dane1(:, 1);
z1 = dane1(:, 2);
t2 = dane2(:, 1);
z2 = dane2(:, 2);
t3 = dane3(:, 1);
z3 = dane3(:, 2);

final_l = min([length(z1) length(z2) length(z3)]);

stairs(z1(1:final_l)); hold on; stairs(z2(1:final_l));
hold on; stairs(z3(1:final_l));
legend('Z = 10', 'Z = 20', 'Z = 30', 'Location', 'northwest');
xlabel('Czas [s]');
ylabel('y');

exportgraphics(gca, 'pomiary/odpowiedzi_skokowe_z.pdf', 'ContentType', 'vector');

close;