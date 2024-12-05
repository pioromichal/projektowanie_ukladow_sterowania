clear;
addpath("Funkcje\");
addpath("funkcje_przynaleznosci\");

kk = 800;
Tp=0.5;
yzad(1:200)=-0.2;yzad(201:400)=2;yzad(401:600)=6;yzad(601:800)=11;

centra_rozmycia = [-0.5 1,4,8]; % Centra rozmycia dla każdego modelu
z_switch = 1;
ilosc_modeli = length(centra_rozmycia);

function E = pid_funkcja_kosztu(parametry, kk, yzad, centra_rozmycia, z_switch)
    ilosc_modeli = length(centra_rozmycia);
    K_values = parametry(1:ilosc_modeli); 
    Ti_values = parametry((1:ilosc_modeli)+ilosc_modeli);
    Td_values = parametry((1:ilosc_modeli)+ilosc_modeli*2); 

    parametry_pid = cell(1, ilosc_modeli);
    for i = 1:ilosc_modeli
        parametry_pid{i} = p5_pid_offline_rozmyty(K_values(i), Ti_values(i), Td_values(i), 0.5);
    end

    [y, ~] = p5_funkcja_pid_rozmyty(kk, yzad, parametry_pid, centra_rozmycia, z_switch);

    E = (yzad-y)*(yzad-y)';
    % E = sum(abs(y-yzad));
end

I=ones(1,ilosc_modeli);
% K_dol = 0.01; K_gor = 3;
% Ti_dol = 0.01; Ti_gor= 10;
% Td_dol = 0; Td_gor= 1;

% parametry_pocz = [0.05*I, 7.0*I, 2.0*I];
% ogr_dol = [K_dol*I, Ti_dol*I, Td_dol*I];  
% ogr_gor = [K_gor*I, Ti_gor*I, Td_gor*I];

K_dol = 0.01; K_gor = 3;
Ti_dol = 0.01; Ti_gor= 10;
Td_dol = 0; Td_gor= 1;

parametry_pocz = [0.5*I, 1.0*I, 0.0*I];
ogr_dol = [K_dol*I, Ti_dol*I, Td_dol*I];  
ogr_gor = [K_gor*I, Ti_gor*I, Td_gor*I];

parametry_optymalne = fmincon(@(parametry) ...
    pid_funkcja_kosztu(parametry, kk, yzad, centra_rozmycia, z_switch), ...
    parametry_pocz, [], [], [], [], ogr_dol, ogr_gor);

% options = optimoptions('ga', 'Display', 'iter');
% parametry_optymalne = ga(@(parametry) ...
%     pid_funkcja_kosztu(parametry, kk, yzad, centra_rozmycia, z_switch), ...
%     ilosc_modeli*3, [], [], [], [], ogr_dol, ogr_gor, [], [], options);

ilosc_modeli = length(centra_rozmycia);
K_values = parametry_optymalne(1:ilosc_modeli); 
Ti_values = parametry_optymalne((1:ilosc_modeli)+ilosc_modeli);
Td_values = parametry_optymalne((1:ilosc_modeli)+ilosc_modeli*2); 

parametry_pid = cell(1, ilosc_modeli);
for i = 1:ilosc_modeli
    parametry_pid{i} = p5_pid_offline_rozmyty(K_values(i), Ti_values(i), Td_values(i), 0.5);
end


disp('Parametry PID dla każdego modelu:');
for i = 1:ilosc_modeli
    fprintf('Model %d: K = %.2f, Ti = %.2f, Td = %.2f\n', i, K_values(i), Ti_values(i), Td_values(i));
end

fprintf('\nGotowy kod do przeklejenia:\n');
fprintf('centra_rozmycia = [%s];\n', num2str(centra_rozmycia, '%.2f '));
fprintf('z_switch = %s;\n', num2str(z_switch, '%.2f '));
fprintf('K_values = [%s];\n', num2str(K_values, '%.5f '));
fprintf('Ti_values = [%s];\n', num2str(Ti_values, '%.5f '));
fprintf('Td_values = [%s];\n', num2str(Td_values, '%.5f '));


[y, u] = p5_funkcja_pid_rozmyty(kk, yzad, parametry_pid, centra_rozmycia, z_switch);

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana', Location='best');

E = (yzad-y)*(yzad-y)';
disp(['E: ', num2str(E)]);