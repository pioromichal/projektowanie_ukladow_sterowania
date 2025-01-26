clear;
addpath('Funkcje\');

% parametry symulacji
kk = 1000; 
Tp = 0.5; 
yzad1 = [repmat(1, 1, kk)]; 
yzad2 = yzad1;
yzad3 = yzad1;
Y_zad = [yzad1; yzad2; yzad3]; 
U_nums = [4, 1, 2]; 

% ograniczenia
K_min = [1, 1, 1];
K_max = [10, 10, 10];
Ti_min = [10, 10, 10];
Ti_max = [200, 200, 200];
Td_min = [0, 0, 0];
Td_max = [0.0, 0.0, 0.0]; 
lower_bounds = [K_min, Ti_min, Td_min];
upper_bounds = [K_max, Ti_max, Td_max];

% parametry początkowe
K_init = [1.0, 1.0, 1.0];
Ti_init = [80.0, 80.0, 80.0];
Td_init = [0.0, 0.0, 0.0];
initial_params = [K_init, Ti_init, Td_init];


IntCon = []; 
options = optimoptions('ga', 'Display', 'iter', 'PopulationSize', 100, ...
                       'MaxGenerations', 200, 'InitialPopulationMatrix', initial_params, ...
                       'UseParallel', false);

optimal_params = ga(@(params) pid_cost_function(params, kk, Tp, Y_zad, U_nums), ...
                    9, [], [], [], [], lower_bounds, upper_bounds, [], IntCon, options);

K_opt = optimal_params(1:3);
Ti_opt = optimal_params(4:6);
Td_opt = optimal_params(7:9);

% wykresy
disp('Optimized PID parameters:');
disp(['K: ', num2str(K_opt)]);
disp(['Ti: ', num2str(Ti_opt)]);
disp(['Td: ', num2str(Td_opt)]);

[Y, U, E] = p3_PID_MIMO(kk, Tp, Y_zad, K_opt, Ti_opt, Td_opt, U_nums);

t = 0:Tp:(kk-1)*Tp;

figure;
plot(t, Y(1, :), t, Y(2, :), t, Y(3, :), t, yzad1, '--');
xlabel('Czas (s)');
ylabel('y');
legend('y1', 'y2', 'y3', 'y_{zad}', 'Location', 'best');
title('Wyjście obiektu');
grid on;
exportgraphics(gcf, 'Wykresy/p5_y_PID.pdf', 'ContentType', 'vector');
close;

figure;
plot(t, U(1, :), t, U(2, :), t, U(3, :));
xlabel('Czas (s)');
ylabel('u');
legend('u1', 'u2', 'u3', 'Location', 'best');
title('Wejście obiektu');
grid on;
exportgraphics(gcf, 'Wykresy/p5_u_PID.pdf', 'ContentType', 'vector');
close;

% --- Funkcja kosztu ---
function cost = pid_cost_function(params, kk, Tp, Y_zad, U_nums)
    K = params(1:3);
    Ti = params(4:6);
    Td = params(7:9);

    [Y, ~, ~] = p3_PID_MIMO(kk, Tp, Y_zad, K, Ti, Td, U_nums);

    error = Y - Y_zad;
    cost = sum(sum(error.^2));
end
