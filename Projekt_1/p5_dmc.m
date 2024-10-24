clear;
kk = 300;
yzad = 2.5;
yzad = yzad*ones(kk,1);
N = 50;
Nu = 50;
D = 200;
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


% zapisz_dane_do_txt(y, "aaa.txt");
% aaa = odczyt_danych_z_txt("aaa.txt");