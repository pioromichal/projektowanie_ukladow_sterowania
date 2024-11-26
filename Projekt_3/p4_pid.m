clear;
kk = 400;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

yzad(1:100)=-0.2;yzad(101:200)=2;yzad(201:300)=6;yzad(301:400)=11;
% Pid początkowy
K = 0.1;
Ti = 6;
Td = 2;

[r2, r1, r0] = pid_offline(K,Ti,Td,0.5);
[yp, up] = p3_funkcja_pid(kk, yzad, r2, r1, r0);


% Pid optymalny
% TODO wyznaczyć jakiś, teraz sa losowe XD

K = 0.09;
Ti = 7.5;
Td = 1.8;

[r2, r1, r0] = pid_offline(K,Ti,Td,0.5);
[y, u] = p3_funkcja_pid(kk, yzad, r2, r1, r0);

% wyniki symulacji
figure; 
stairs(time,u); hold on; stairs(time,up);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
legend('u: PID dostrojony', 'u: PID początkowy', 'Location','southeast');
title('Sygnał wejściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/p4_pid_u.pdf', 'ContentType', 'vector');
% close;

figure; stairs(time,y); hold on; stairs(time,yp); stairs(time,yzad,'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
legend('y: PID dostrojony', 'y: PID początkowy', 'y_{zad}', 'Location','southeast');
title('Sygnał wyjściowy'); % Tytuł wykresu
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/p4_pid_y.pdf', 'ContentType', 'vector');
% close;

Ep = (yzad-yp')'*(yzad-yp');
E = (yzad-y')'*(yzad-y');
% disp([K Ti Td E Ep])


