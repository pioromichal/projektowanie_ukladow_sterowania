clear;
addpath("Funkcje\");

kk = 400;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

yzad(1:100)=-0.2;yzad(101:200)=2;yzad(201:300)=6;yzad(301:400)=11;

% DMC początkowy
N = 50;
Nu = 50;
D = 50;
lambda = 1;


[yp, up] = p3_funkcja_dmc(kk, yzad, N, Nu, D, lambda);


% DMC optymalny
% TODO wyznaczyć bo są losowe

N = 40;
Nu = 40;
D = 40;
lambda = 1;

[y, u] = p3_funkcja_dmc(kk, yzad, N, Nu, D, lambda);

% wyniki symulacji
figure; 
stairs(time,u); hold on; stairs(time,up);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: DMC dostrojony', 'u: DMC początkowy', 'Location','southeast');
title('Sygnał wejściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/p4_dmc_u.pdf', 'ContentType', 'vector');
% close;

figure; stairs(time,y); hold on; stairs(time,yp); stairs(time,yzad,'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: DMC dostrojony', 'y: DMC początkowy', 'y_{zad}', 'Location','southeast');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/p4_dmc_y.pdf.pdf', 'ContentType', 'vector');
% close;

Ep = (yzad-yp')'*(yzad-yp');
E = (yzad-y')'*(yzad-y');
% disp([E Ep])
