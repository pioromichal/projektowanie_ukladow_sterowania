clear; close all;

kk = 300;
yzad = 4.2;
yzad = yzad*ones(kk,1);
% yzad(1:9)=4; yzad(10:kk)=4.1;
Kk = 0.1;
Tk = 5;
[y, u] = p4_funkcja_pid(kk, yzad, Kk, Tk);

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;
% close;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana');
% close;

E = (yzad-y')'*(yzad-y');
disp([Kk Tk E])