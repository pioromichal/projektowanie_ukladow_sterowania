clear;
kk = 400;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

% Symulacja dla y_zad=2.5
yzad = 2.5;
yzad = yzad*ones(kk,1);

% Pid optymalizowany
r0 = 0.36243;
r1 = -0.26243;
r2 = -0.081289;
[yp, up] = p4_funkcja_pid(kk, yzad, r2, r1, r0);


% Pid eksperymentalny

K = 0.09;
Ti = 7.5;
Td = 1.8;

[r2, r1, r0] = p4_pid_dyskretyzacja_param(K,Ti,Td,0.5);
[y, u] = p4_funkcja_pid(kk, yzad, r2, r1, r0);

% wyniki symulacji
figure; 
stairs(time,u); hold on; stairs(time,up);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: PID eksperymentalny', 'u: PID optymalizowany', 'Location','southeast');
title('Sygnał wejściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'rysunki/projekt/Zad6/PID_u_ostateczny_2_5.pdf', 'ContentType', 'vector');
close;

figure; stairs(time,y); hold on; stairs(time,yp); stairs(time,yzad,'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: PID eksperymentalny', 'y: PID optymalizowany', 'y_{zad}', 'Location','southeast');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'rysunki/projekt/Zad6/PID_y_ost_2_5.pdf', 'ContentType', 'vector');
close;

Ep = (yzad-yp')'*(yzad-yp');
E = (yzad-y')'*(yzad-y');
disp([K Ti Td E Ep])


% Symulacja dla y_zad=1.2 

yzad = 1.2;
yzad = yzad*ones(kk,1);

% Pid optymalizowany
r0 = 0.36243;
r1 = -0.26243;
r2 = -0.081289;
[yp, up] = p4_funkcja_pid(kk, yzad, r2, r1, r0);

% Symulacja dla y_zad=1.2 PIDa eksperymentalny
K = 0.09;
Ti = 7.5;
Td = 1.8;

[r2, r1, r0] = p4_pid_dyskretyzacja_param(K,Ti,Td,0.5);
[y, u] = p4_funkcja_pid(kk, yzad, r2, r1, r0);

% wyniki symulacji
figure; 
stairs(time,u); hold on; stairs(time,up);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: PID eksperymentalny', 'u: PID optymalizowany');
title('Sygnał wejściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'rysunki/projekt/Zad6/PID_u_ostateczny_1_2.pdf', 'ContentType', 'vector');
close;

figure; stairs(time,y); hold on; stairs(time,yp); stairs(time,yzad,'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: PID eksperymentalny', 'y: PID optymalizowany', 'y_{zad}');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'rysunki/projekt/Zad6/PID_y_ost_1_2.pdf', 'ContentType', 'vector');
close;


Ep = (yzad-yp')'*(yzad-yp');
E = (yzad-y')'*(yzad-y');
disp([K Ti Td E Ep])