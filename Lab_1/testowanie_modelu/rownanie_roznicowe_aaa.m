clear;close all;

Ko = 0.010881;
To = 9;
T1 = 83.3474;
T2 = 2.4876;
Tp = 1;

s = tf('s'); % określenie transmitancji jako wyrażenia z 's'
NUM = Ko*exp(-To*s);
DEN = (T1*s+1)*(T2*s+1);

Gs = NUM/DEN;
Gz = c2d(Gs, Tp, 'zoh');

b1 = Gz.Numerator{1}(2);
b0 = Gz.Numerator{1}(3);
a1 = Gz.Denominator{1}(2);
a0 = Gz.Denominator{1}(3);
% num2str(
disp("y(k) = " + num2str(-a1) + "*y(k-1) "+num2str(-a0)+"*y(k-2) + "+ ...
    num2str(b1)+"*u(k-"+num2str(To+1)+") + "+num2str(b0)+"*u(k-"+num2str(To+2)+");")

% Gs
% Gz
% Kc = dcgain(Gs)
% Kd = dcgain(Gz)

% figure;
% hold on;
% % t_c = linspace(0, 50, 100);
% % t_d = 0:Tp:50;
% % plot(t_c,step(Gs,t_c));
% % plot(t_d,step(Gz,t_d));
% step(Gs)
% step(Gz)
% xlabel('Czas [s]')
% ylabel('Amplituda')
% title('Odpowiedź skokowa transmitancji');
% legend('Ciągła', 'Dyskretna');
% grid on;
% 
% filename = 'Materiały/1_porownanie.png';
% dpi = 400;
% % print(filename, '-dpng', ['-r' num2str(dpi)]);
% % close;
