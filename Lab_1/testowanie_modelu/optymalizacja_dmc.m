clear all;

function E = dmc_funkcja_kosztu(parametry, kk, yzad, D)
    N = parametry(1); % Zaokrąglamy, bo N musi być całkowite
    Nu = parametry(2); % Zaokrąglamy, bo Nu musi być całkowite
    lambda = parametry(3);

    [y, ~]=funkcja_dmc(kk, yzad, N, Nu, D, lambda);

    E = ((yzad - y')' * (yzad - y'));
end

kk=500;
yzad = 35;
yzad = yzad*ones(kk,1);
D = 700;

ogr_dol = [5, 3, 0.001];  
ogr_gor = [600, 60, 1];
parametry_pocz = [600, 60, 0.01];

IntCon = [1, 2];  % N i Nu muszą być liczbami całkowitymi
options = optimoptions('ga', 'Display', 'iter', 'InitialPopulationMatrix', parametry_pocz); % Opcje algorytmu genetycznego

parametry_optymalne = ga(@(parametry) dmc_funkcja_kosztu(parametry, kk, yzad, D), 3, [], [], [], [], ogr_dol, ogr_gor, [], IntCon, options);

N=parametry_optymalne(1);
Nu=parametry_optymalne(2);
lambda=parametry_optymalne(3);

disp('Optymalne parametry DMC:');
disp(['N: ', num2str(N)]);
disp(['Nu: ', num2str(Nu)]);
disp(['lambda: ', num2str(lambda)]);

% N = 400;
% Nu = 3;
% lambda = 0.03;

[y,u]=funkcja_dmc(kk, yzad, N, Nu, D, lambda);



% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;
% close;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana');
% close;
E = (yzad - y')' * (yzad - y');
disp(['E: ', num2str(E)]);