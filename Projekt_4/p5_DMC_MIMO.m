clear;
addpath('Funkcje\');

% Parametry symulacji
kk = 1200; 
Tp = 0.5; 
yzad1 = [repmat(1, 1, 200), repmat(3, 1, 200), repmat(0.5, 1, 200), ...
         repmat(-0.5, 1, 200), repmat(1.5, 1, 200), repmat(4, 1, 200)];
yzad2 = yzad1;
yzad3 = yzad1;
Y_zad = [yzad1; yzad2; yzad3]; 
D = 200;
N = 200;
Nu = 200;

% Ograniczenia
lambda_min = [0.1, 0.1, 0.1, 0.1];
lambda_max = [100, 100, 100, 100];
psi_min = [0, 0, 0];
psi_max = [100, 100, 100];
lower_bounds = [lambda_min, psi_min];
upper_bounds = [lambda_max, psi_max];

% Parametry początkowe
lambda_init = [1.0, 1.0, 1.0, 1.0];
psi_init = [1.0, 1.0, 1.0];
initial_params = [lambda_init, psi_init];

PopulationSize = 50; 
InitialPopulationMatrix = repmat(initial_params, PopulationSize, 1); 

IntCon = []; 
options = optimoptions('ga', 'Display', 'iter', 'PopulationSize', PopulationSize, ...
                       'MaxGenerations', 20, 'InitialPopulationMatrix', InitialPopulationMatrix, ...
                       'UseParallel', false);

optimal_params = ga(@(params) dmc_cost_function(params, kk, Y_zad, D, N, Nu), ...
                    7, [], [], [], [], lower_bounds, upper_bounds, [], IntCon, options);

lambda_opt = optimal_params(1:4);
psi_opt = optimal_params(5:7);

disp('Optimized DMC parameters:');
disp(['lambda: ', num2str(lambda_opt)]);
disp(['psi: ', num2str(psi_opt)]);

[Y, U, E] = p3_DMC_MIMO(kk, Y_zad, D, N, Nu, lambda_opt, psi_opt);

t = 0:Tp:(kk-1)*Tp;

figure;
plot(t, Y(1, 1:kk), t, Y(2, 1:kk), t, Y(3, 1:kk), t, yzad1(1:kk), '--');
xlabel('Czas (s)');
ylabel('y');
legend('y1', 'y2', 'y3', 'y_{zad}', 'Location', 'best');
title('Wyjście obiektu');
grid on;
exportgraphics(gcf, 'Wykresy/p5_y_DMC.pdf', 'ContentType', 'vector');
close;

figure;
plot(t, U(1, 1:kk), t, U(2, 1:kk), t, U(3, 1:kk), t, U(4, 1:kk));
xlabel('Czas (s)');
ylabel('u');
legend('u1', 'u2', 'u3', 'u4', 'Location', 'best');
title('Wejście obiektu');
grid on;
exportgraphics(gcf, 'Wykresy/p5_u_DMC.pdf', 'ContentType', 'vector');
close;

% --- Funkcja kosztu ---
function E = dmc_cost_function(params, kk, Y_zad, D, N, Nu)
    lambda = params(1:4);
    psi = params(5:end);

    [~, ~, E] = p3_DMC_MIMO(kk, Y_zad, D, N, Nu, lambda, psi);
end
