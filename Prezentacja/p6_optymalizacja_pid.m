clear;

kk = 100;
yzad = 1;
yzad = yzad*ones(kk,1); Tp = 1;

parametry_pocz = [1, 1, 1];
ogr_dol = [0,0,0];  
ogr_gor = [20, 15, 1];

parametry_optymalne = fmincon(@(parametry) ...
    pid_funkcja_kosztu(parametry, kk, yzad), ...
    parametry_pocz, [], [], [], [], ogr_dol, ogr_gor);

K=parametry_optymalne(1);
Ti=parametry_optymalne(2);
Td=parametry_optymalne(3);

disp('Optymalne parametry PID:');
disp(['K = ', num2str(K), ';']);
disp(['Ti = ', num2str(Ti), ';']);
disp(['Td = ', num2str(Td), ';']);

r2 = K*Td/Tp;
r1 = K*(Tp/(2*Ti) - (2*Td)/Tp - 1);
r0 = K*(1 + Tp/(2*Ti) + Td/Tp);


[y, u] = p4_funkcja_pid(kk, yzad, r2,r1,r0);

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana');

E = (yzad-y')'*(yzad-y');
disp(['E: ', num2str(E)]);

function E = pid_funkcja_kosztu(parametry, kk, yzad)
    K = parametry(1);
    Ti = parametry(2);
    Td = parametry(3);
    Tp = 1;

    r2 = K*Td/Tp;
    r1 = K*(Tp/(2*Ti) - (2*Td)/Tp - 1);
    r0 = K*(1 + Tp/(2*Ti) + Td/Tp);

    [y, ~] = p4_funkcja_pid(kk, yzad, r2, r1, r0);
    
    E = (yzad-y')'*(yzad-y');
end