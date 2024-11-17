clear;
kk = 100;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

% Wektor zakłóceń
z(1:kk+7)=0;

% DMC początkowy
Dp = 140;
Np = Dp;
Nup = Dp;
lambdap = 1;

% DMC dostrojony
N = 20;
Nu = 3;
D = 192;
lambda = 0.5;

% DMC optymalny
% No = 8;
% Nuo = 1;
% Do = 192;
% lambdao = 0.0023567;

No = 60;
Nuo = 2;
Do = 192;
lambdao = 0.05;

% Symulacja dla y_zad=1
yzad = 1;

[yp, up] = p4_funkcja_dmc(kk, yzad, Np, Nup, Dp, lambdap, z);
[y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda, z);
% [yo, uo] = p4_funkcja_dmc(kk, yzad, No, Nuo, Do, lambdao, z);


% wyniki symulacji
figure; 
stairs(time,u); hold on; stairs(time,up, '-.'); 
% stairs(time,uo, '-');
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
% legend('u: DMC dostrojony', 'u: DMC początkowy', 'u: DMC optymalizowany', 'Location','southeast');
legend('u: DMC dostrojony', 'u: DMC początkowy', 'Location','southeast');
title('Sygnał wejściowy'); % Tytuł wykresu
zamien_kropki();
exportgraphics(gcf, 'Wykresy/Z4_DMC_u_m.pdf', 'ContentType', 'vector');
close;

figure; stairs(time,y); hold on; stairs(time,yp, '-.'); 
% stairs(time,yo, '--');  
stairs(time,yzad*ones(kk,1),':');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: DMC dostrojony', 'y: DMC początkowy', 'y_{zad}', 'Location','southeast');
% legend('y: DMC dostrojony', 'y: DMC początkowy', 'y: DMC optymalizowany', 'y_{zad}', 'Location','southeast');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/Z4_DMC_y_m.pdf', 'ContentType', 'vector');
close;

Ep = (yzad-yp')'*(yzad-yp');
E = (yzad-y')'*(yzad-y');
% Eo = (yzad-yo')'*(yzad-yo');
disp(['Błąd DMC początkowego: ', num2str(Ep)]);
disp(['Błąd DMC dostrojonego: ', num2str(E)]);
% disp(['Błąd DMC optymalizwoanego: ', num2str(Eo)]);


% Symulacja dla y_zad=1.2 

yzad = 4;

[yp, up] = p4_funkcja_dmc(kk, yzad, Np, Nup, Dp, lambdap, z);
[y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda, z);
[yo, uo] = p4_funkcja_dmc(kk, yzad, No, Nuo, Do, lambdao, z);

% wyniki symulacji
figure; 
stairs(time,u); hold on; stairs(time,up, '-.'); 
% stairs(time,uo, '-');
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: DMC dostrojony', 'u: DMC początkowy');
% legend('u: DMC dostrojony', 'u: DMC początkowy', 'u: DMC optymalizowany');
title('Sygnał wejściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/Z4_DMC_u_d.pdf', 'ContentType', 'vector');
close;

figure; stairs(time,y); hold on; stairs(time,yp, '-.'); 
% stairs(time,yo, '--');  
stairs(time,yzad*ones(kk,1),':');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: DMC dostrojony', 'y: DMC początkowy', 'y_{zad}');
% legend('y: DMC dostrojony', 'y: DMC początkowy', 'y: DMC optymalizowany', 'y_{zad}');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/Z4_DMC_y_d.pdf', 'ContentType', 'vector');
close;


Ep = (yzad-yp')'*(yzad-yp');
E = (yzad-y')'*(yzad-y');
% Eo = (yzad-yo')'*(yzad-yo');
disp(['Błąd DMC początkowego: ', num2str(Ep)]);
disp(['Błąd DMC dostrojonego: ', num2str(E)]);
% disp(['Błąd DMC optymalizwoanego: ', num2str(Eo)]);