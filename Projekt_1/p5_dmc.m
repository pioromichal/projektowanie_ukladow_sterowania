clear;
kk = 400;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

% Symulacja dla y_zad=2.5
yzad = 2.5;
yzad = yzad*ones(kk,1);

% DMC początkowy
N = 17;
Nu = 10;
D = 130;
lambda = 1;


[yp, up] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda);


% DMC optymalny

N = 35;
Nu = 30;
D = 130;
lambda = 3;

[y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda);

% wyniki symulacji
figure; 
stairs(time,u); hold on; stairs(time,up);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: DMC dostrojony', 'u: DMC początkowy', 'Location','southeast');
title('Sygnał wejściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'rysunki/projekt/Zad5/DMC_u_ostateczny_2_5.pdf', 'ContentType', 'vector');
close;

figure; stairs(time,y); hold on; stairs(time,yp); stairs(time,yzad,'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: DMC dostrojony', 'y: DMC początkowy', 'y_{zad}', 'Location','southeast');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'rysunki/projekt/Zad5/DMC_y_ost_2_5.pdf', 'ContentType', 'vector');
close;

Ep = (yzad-yp')'*(yzad-yp');
E = (yzad-y')'*(yzad-y');
disp([E Ep])


% Symulacja dla y_zad=1.2 

yzad = 1.2;
yzad = yzad*ones(kk,1);

% DMC początkowy
N = 17;
Nu = 10;
D = 130;
lambda = 1;

[yp, up] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda);

% DMC optymalny
N = 35;
Nu = 30;
D = 130;
lambda = 3;

[y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda);

% wyniki symulacji
figure; 
stairs(time,u); hold on; stairs(time,up);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: DMC dostrojony', 'u: DMC początkowy');
title('Sygnał wejściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'rysunki/projekt/Zad5/DMC_u_ostateczny_1_2.pdf', 'ContentType', 'vector');
close;

figure; stairs(time,y); hold on; stairs(time,yp); stairs(time,yzad,'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: DMC dostrojony', 'y: DMC początkowy', 'y_{zad}');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'rysunki/projekt/Zad5/DMC_y_ost_1_2.pdf', 'ContentType', 'vector');
close;


Ep = (yzad-yp')'*(yzad-yp');
E = (yzad-y')'*(yzad-y');
disp([E Ep])