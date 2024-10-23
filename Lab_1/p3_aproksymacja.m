clear;
parametry_pocz = [1, 1, 1, 1];
kk = 100;

% zaladowac prawdziwe ymierz i umierz
u(1:30)=0; u(31:kk)=1;
% ymierz = symulacja_pomiarow(kk,u)';
% ymierz=ones(kk,1);
ymierz = odczyt_danych_z_txt("skok_1_27.txt");

ogr_dol = [1, 1, 0, 0];  
ogr_gor = [60, 60, 50, 20];

% Używamy algorytmu genetycznego
IntCon = 4;  % Td musi być liczbą całkowitą
options = optimoptions('ga', 'Display', 'iter'); % Opcje algorytmu genetycznego

parametry_optymalne = ga(@(parametry) funkcja_kosztu(parametry, kk, u, ymierz), 4, [], [], [], [], ogr_dol, ogr_gor, [], IntCon, options);

T1 = parametry_optymalne(1);
T2 = parametry_optymalne(2);
K = parametry_optymalne(3);
Td = parametry_optymalne(4);

disp('Optymalne parametry DMC:');
disp(['T1: ', num2str(T1)]);
disp(['T2: ', num2str(T2)]);
disp(['K: ', num2str(K)]);
disp(['Td: ', num2str(Td)]);

y = model(T1,T2,K,Td,kk,u);

% wyniki symulacji
% figure; stairs(u);
% ylabel('u'); xlabel('k'); grid on; grid minor;
% % close;

figure; stairs(y); hold on; stairs(ymierz,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Model', 'Pomiar');
% close;

E = (ymierz-y)'*(ymierz-y);
disp(['E: ', num2str(E)]);