clear;
kk = 300;
yzad = 4.2;
yzad = yzad*ones(kk,1);
N = 17;
Nu = 20;
D = 80;
lambda = 5;

[y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda);

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana');

E = (yzad-y')'*(yzad-y');
disp([N Nu D E])