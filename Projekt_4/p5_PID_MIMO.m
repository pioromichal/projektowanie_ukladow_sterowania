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
U_nums = [3,4,2]; 

% Ograniczenia
K_min = [0, 0, 0];
K_max = [10, 10, 10];
Ti_min = [0, 0, 0];
Ti_max = [200, 200, 200];
Td_min = [0, 0, 0];
Td_max = [0.1, 0.1, 0.1];
lower_bounds = [K_min, Ti_min, Td_min];
upper_bounds = [K_max, Ti_max, Td_max];

% Parametry początkowe
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

% Wykresy
disp('Optimized PID parameters:');
disp(['K: ', num2str(K_opt)]);
disp(['Ti: ', num2str(Ti_opt)]);
disp(['Td: ', num2str(Td_opt)]);

[Y, U, E] = p3_PID_MIMO(kk, Tp, Y_zad, K_opt, Ti_opt, Td_opt, U_nums);

t = 0:Tp:(kk-1)*Tp;

figure;
plot(t, Y(1,1:kk), t, Y(2,1:kk), t, Y(3,1:kk), t, yzad1(1:kk), '--');
xlabel('Czas (s)');
ylabel('y');
legend('y1', 'y2', 'y3', 'y_{zad}', 'Location', 'best');
title('Wyjście obiektu');
grid on;
file_suffix = strjoin(string(U_nums), '_'); % Połączenie elementów wektora z podkreślnikami
filename = ['Wykresy/p5_y_PID_'+ file_suffix+ '.pdf']; % Składanie nazwy pliku
exportgraphics(gcf, filename, 'ContentType', 'vector');
% close;

figure;
plot(t, U(1,1:kk), t, U(2,1:kk), t, U(3,1:kk), t, U(4,1:kk));
xlabel('Czas (s)');
ylabel('u');
legend('u1', 'u2', 'u3', 'u4', 'Location', 'best');
title('Wejście obiektu');
grid on;
file_suffix = strjoin(string(U_nums), '_'); % Połączenie elementów wektora z podkreślnikami
filename = ['Wykresy/p5_u_PID_'+ file_suffix+ '.pdf']; % Składanie nazwy pliku
exportgraphics(gcf, filename, 'ContentType', 'vector');
% close;

% --- Funkcja kosztu ---
function E = pid_cost_function(params, kk, Tp, Y_zad, U_nums)
    K = params(1:3);
    Ti = params(4:6);
    Td = params(7:9);

    [~, ~, E] = p3_PID_MIMO(kk, Tp, Y_zad, K, Ti, Td, U_nums);
end
