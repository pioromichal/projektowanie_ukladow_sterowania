clear;
kk = 600;
Tp=0.5;
time=0:Tp:Tp*(kk-1);
yzad(1:100)=-0.2;yzad(101:200)=2;yzad(201:300)=6;yzad(301:400)=11;
yzad(401:500)=0; yzad(501:600)=6;

%% 2 regulatory lokalne

% PID
[yp, up, Ep] = p5_pid_rozmyty(2);
disp(Ep)

% DMC
[yd, ud, Ed] = p5_dmc_rozmyty(2);
disp(Ed)

figure;
hold on; stairs(time,up); hold on; stairs(time, ud);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
title('Sygnał wejściowy');
legend('PID', 'DMC');
zamien_kropki();
exportgraphics(gcf, 'Wykresy/p6_2_u.pdf', 'ContentType', 'vector');
close;

figure;  hold on; stairs(time,yp); hold on; stairs(time, yd); hold on;
stairs(time,yzad(1:kk),'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
title('Sygnał wyjściowy'); 
legend('PID', 'DMC', 'y_{zad}');
zamien_kropki();
exportgraphics(gcf, 'Wykresy/p6_2_y.pdf', 'ContentType', 'vector');
close;

%% 3 regulatory lokalne

% PID
[yp, up, Ep] = p5_pid_rozmyty(3);
disp(Ep)

% DMC
[yd, ud, Ed] = p5_dmc_rozmyty(3);
disp(Ed)

figure;
hold on; stairs(time,up); hold on; stairs(time, ud);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
title('Sygnał wejściowy');
legend('PID', 'DMC');
zamien_kropki();
exportgraphics(gcf, 'Wykresy/p6_3_u.pdf', 'ContentType', 'vector');
close;

figure;  hold on; stairs(time,yp); hold on; stairs(time, yd); hold on;
stairs(time,yzad(1:kk),'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
title('Sygnał wyjściowy'); 
legend('PID', 'DMC', 'y_{zad}');
zamien_kropki();
exportgraphics(gcf, 'Wykresy/p6_3_y.pdf', 'ContentType', 'vector');
close;

%% 4 regulatory lokalne

% PID
[yp, up, Ep] = p5_pid_rozmyty(4);
disp(Ep)

% DMC
[yd, ud, Ed] = p5_dmc_rozmyty(4);
disp(Ed)

figure;
hold on; stairs(time,up); hold on; stairs(time, ud);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
title('Sygnał wejściowy');
legend('PID', 'DMC');
zamien_kropki();
exportgraphics(gcf, 'Wykresy/p6_4_u.pdf', 'ContentType', 'vector');
close;

figure;  hold on; stairs(time,yp); hold on; stairs(time, yd); hold on;
stairs(time,yzad(1:kk),'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
title('Sygnał wyjściowy'); 
legend('PID', 'DMC', 'y_{zad}');
zamien_kropki();
exportgraphics(gcf, 'Wykresy/p6_4_y.pdf', 'ContentType', 'vector');
close;

%% 5 regulatory lokalne

% PID
[yp, up, Ep] = p5_pid_rozmyty(5);
disp(Ep)

% DMC
[yd, ud, Ed] = p5_dmc_rozmyty(5);
disp(Ed)

figure;
hold on; stairs(time,up); hold on; stairs(time, ud);
ylabel('u'); xlabel('t [s]'); grid on; grid minor;
title('Sygnał wejściowy');
legend('PID', 'DMC');
zamien_kropki();
exportgraphics(gcf, 'Wykresy/p6_5_u.pdf', 'ContentType', 'vector');
close;

figure;  hold on; stairs(time,yp); hold on; stairs(time, yd); hold on;
stairs(time,yzad(1:kk),'--');
xlabel('t [s]'); ylabel('y'); grid on; grid minor;
title('Sygnał wyjściowy'); 
legend('PID', 'DMC', 'y_{zad}');
zamien_kropki();
exportgraphics(gcf, 'Wykresy/p6_5_y.pdf', 'ContentType', 'vector');
close;