clear all;

kk = 201;

sp = p2_odpowiedzi_skokowe(kk);

Tp = 0.5;
time = 0:Tp:Tp*(kk-1); 

% wykres

figure;

% ograniczenia osi Y
y_min = 0; 
y_max = 2.7; 

colors = ['b', 'r', 'g', 'm']; 

titles = ["y1", "y2", "y3"]; 
for i = 1:4 % dla każdego wejścia u_i
    for j = 1:3 % dla każdego wyjścia y_j
        subplot(4, 3, (i-1)*3 + j);
        plot(time, squeeze(sp(j, i, :)), colors(i)); 
        title(['u_' num2str(i) ' → y_' num2str(j)], 'FontSize', 10, 'Interpreter', 'tex');
        xlabel('Czas [s]', 'FontSize', 9);
        ylabel(['y_' num2str(j)], 'FontSize', 9);
        ylim([y_min y_max]); 
        grid on;
    end
end

exportgraphics(gcf, 'Wykresy/p2_odpowiedzi_skokowe.pdf', 'ContentType', 'vector');
% close;