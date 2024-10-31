clear;
function E = dmc_funkcja_kosztu(parametry, kk, yzad, D)
    N = round(parametry(1));
    Nu = round(parametry(2));
    lambda = parametry(3);

    [y, ~] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda);
    
    E = (yzad - y')' * (yzad - y');
end

parametry_pocz = [30, 30, 1];
kk = 300;
yzad = 2.5;
yzad = yzad * ones(kk, 1);
D = 130;

ogr_dol = [1, 1, 0.0];  
ogr_gor = [60, 100, 50];

IntCon = [1, 2];
options = optimoptions('ga', 'Display', 'iter');

parametry_optymalne = ga(@(parametry) ...
    dmc_funkcja_kosztu(parametry, kk, yzad, D), ...
    3, [], [], [], [], ogr_dol, ogr_gor, [], IntCon, options);

N=parametry_optymalne(1);
Nu=parametry_optymalne(2);
lambda=parametry_optymalne(3);

disp('Optymalne parametry DMC:');
disp(['N: ', num2str(N)]);
disp(['Nu: ', num2str(Nu)]);
disp(['lambda: ', num2str(lambda)]);

[y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda);

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;
% close;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana');
% close;

E = (yzad-y')'*(yzad-y');
disp(['E: ', num2str(E)]);