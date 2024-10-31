function E = pid_funkcja_kosztu(parametry, kk, yzad)
    r0 = parametry(1);
    r1 = parametry(2);
    r2 = parametry(3);

    [y, ~] = p4_funkcja_pid(kk, yzad, r2, r1, r0);
    
    E = (yzad-y')'*(yzad-y');
end

clear;
parametry_pocz = [0.0, 0.0, 0.0];
kk = 1000;
yzad = 2.5;
yzad = yzad*ones(kk,1);

ogr_dol = [-1, -1, -1];  
ogr_gor = [1, 1, 1];

parametry_optymalne = fmincon(@(parametry) ...
    pid_funkcja_kosztu(parametry, kk, yzad), ...
    parametry_pocz, [], [], [], [], ogr_dol, ogr_gor);

r2=parametry_optymalne(3);
r1=parametry_optymalne(2);
r0=parametry_optymalne(1);

disp('Optymalne parametry PID:');
disp(['r0: ', num2str(r0)]);
disp(['r1: ', num2str(r1)]);
disp(['r2: ', num2str(r2)]);

[y, u] = p4_funkcja_pid(kk, yzad, r2, r1, r0);

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana');

E = (yzad-y')'*(yzad-y');
disp(['E: ', num2str(E)]);