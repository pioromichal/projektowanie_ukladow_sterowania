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
kk = 900;
% yzad = 35;
% yzad = yzad*ones(kk,1);
yzad(1:450,1)=35;yzad(451:900,1)=40;

ogr_dol = [0, 0, 0.2];  
ogr_gor = [30, 100, 5];

% options = optimoptions('ga', 'Display', 'iter', 'InitialPopulationMatrix', parametry_pocz); % Opcje algorytmu genetycznego
% parametry_optymalne = ga(@(parametry) pid_funkcja_kosztu(parametry, kk, yzad), 3, [], [], [], [], ogr_dol, ogr_gor, [], [], options);

% parametry_optymalne = fmincon(@(parametry) pid_funkcja_kosztu(parametry, kk, yzad), parametry_pocz, [], [], [], [], ogr_dol, ogr_gor);
% 
% r2=parametry_optymalne(3);
% r1=parametry_optymalne(2);
% r0=parametry_optymalne(1);
 
% [r2,r1,r0]=p4_pid_strojenie(parametry_optymalne(1),parametry_optymalne(2),parametry_optymalne(3),1);


disp('Optymalne parametry PID:');
% disp(['r0: ', num2str(r0)]);
% disp(['r1: ', num2str(r1)]);
% disp(['r2: ', num2str(r2)]);

% disp(['K: ', num2str(parametry_optymalne(1))]);
% disp(['Ti: ', num2str(parametry_optymalne(2))]);
% disp(['Td: ', num2str(parametry_optymalne(3))]);


% 15,3505
% Ti 45,0000
% TD 0,3602
% [r2,r1,r0]=p4_pid_strojenie(11,80,0.3,1);
[r2,r1,r0]=p4_pid_strojenie(15.3505,45,0.3602,1);

[y, u] = funkcja_pid(kk, yzad, r2, r1, r0);

set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultTextFontName', 'Arial');

% wyniki symulacji
% figure; stairs(u);
% ylabel('u'); xlabel('k'); grid on; grid minor;
% 
% figure; stairs(y); hold on; stairs(yzad,':');
% xlabel('k'); ylabel('y'); grid on; grid minor;
% legend('Wyjście', 'Wartość zadana');

E = (yzad-y')'*(yzad-y');
disp(['E: ', num2str(E)]);

figure;
stairs(u,'LineWidth', 0.6);
xlabel('Czas [s]');
ylabel('Sygnał sterujący');
title('Wykres sygnału sterującego');
grid on;

% exportgraphics(gca, "wykresy/sym_pid_2_u.pdf", 'ContentType', 'vector');


figure;
% yzad = [yzad1*ones(1, 450), yzad2*ones(1, 450)];
stairs(y,'LineWidth', 0.6); 
hold on; stairs(yzad, '--','LineWidth', 0.6);
xlabel('Czas [s]');
ylabel('Sygnał wyjściowy, zadany');
legend('y', 'y_{zad}', 'Location', 'northwest')
title('Wykres sygnału wyjściowego');
grid on;

% exportgraphics(gca, "wykresy/sym_pid_2_y.pdf", 'ContentType', 'vector');
