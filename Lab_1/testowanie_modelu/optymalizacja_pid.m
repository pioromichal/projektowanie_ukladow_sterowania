function E = pid_funkcja_kosztu(parametry, kk, yzad)
    [r2,r1,r0]=p4_pid_strojenie(parametry(1),parametry(2),parametry(3),1);

    % r0 = parametry(1);
    % r1 = parametry(2);
    % r2 = parametry(3);

    [y, ~] = funkcja_pid(kk, yzad, r2, r1, r0);
    
    E = (yzad-y')'*(yzad-y');
end

clear;
parametry_pocz = [5.0, 100.0, 5.0];

% testowanie danych z laboratorium
kk = 600;
yzad = 35;
yzad = yzad*ones(kk,1);

ogr_dol = [0, 0, 0];  
ogr_gor = [40, 200, 20];

parametry_optymalne = fmincon(@(parametry) pid_funkcja_kosztu(parametry, kk, yzad), parametry_pocz, [], [], [], [], ogr_dol, ogr_gor);
% 
r2=parametry_optymalne(3);
r1=parametry_optymalne(2);
r0=parametry_optymalne(1);
 
[r2,r1,r0]=p4_pid_strojenie(parametry_optymalne(1),parametry_optymalne(2),parametry_optymalne(3),1);

disp('Optymalne parametry PID:');
% disp(['r0: ', num2str(r0)]);
% disp(['r1: ', num2str(r1)]);
% disp(['r2: ', num2str(r2)]);

disp(['K: ', num2str(parametry_optymalne(1))]);
disp(['Ti: ', num2str(parametry_optymalne(2))]);
disp(['Td: ', num2str(parametry_optymalne(3))]);

[y, u] = funkcja_pid(kk, yzad, r2, r1, r0);

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana');

E = (yzad-y')'*(yzad-y');
disp(['E: ', num2str(E)]);