clear;

kk = 600;
yzad = 2.5;
yzad = yzad*ones(kk,1);
% yzad(1:9)=4; yzad(10:kk)=4.1;
K = 0.09;
Ti = 7.5;
Td = 1.8;

[r2, r1, r0] = p4_pid_dyskretyzacja_param(K,Ti,Td,0.5);
% r2 = 0.1;
% r1 = 0.1;
% r0 = 0.1;

[y, u] = p4_funkcja_pid(kk, yzad, r2, r1, r0);

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;
% close;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana');
% close;

E = (yzad-y')'*(yzad-y');
disp([K Ti Td E])