clear;
clear;
function E = dmc_funkcja_kosztu(parametry, kk, yzad, D)
    N = round(parametry(1)); % Zaokrąglamy, bo N musi być całkowite
    Nu = round(parametry(2)); % Zaokrąglamy, bo Nu musi być całkowite
    lambda = parametry(3);

    [y, ~] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda);
    
    E = (yzad - y')' * (yzad - y');
end

parametry_pocz = [20, 20, 3];
kk = 300;
yzad = 4.15;
yzad = yzad * ones(kk, 1);
D = 100;

ogr_dol = [1, 1, 0.0];  
ogr_gor = [60, 100, 50];

% Używamy algorytmu genetycznego
IntCon = [1, 2];  % N i Nu muszą być liczbami całkowitymi
options = optimoptions('ga', 'Display', 'iter'); % Opcje algorytmu genetycznego

parametry_optymalne = ga(@(parametry) dmc_funkcja_kosztu(parametry, kk, yzad, D), 3, [], [], [], [], ogr_dol, ogr_gor, [], IntCon, options);


disp('Optymalne parametry PID:');
disp(['N: ', num2str(parametry_optymalne(1))]);
disp(['Nu: ', num2str(parametry_optymalne(2))]);
disp(['lambda: ', num2str(parametry_optymalne(3))]);

N=parametry_optymalne(1);
Nu=parametry_optymalne(2);
lambda=parametry_optymalne(3);

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