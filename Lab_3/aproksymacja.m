clear;

% zaladowac prawdziwe ymierz i umierz
ymierz = odczyt_danych_z_txt('Pomiary/skok_25_40');
ymierz = (ymierz-ymierz(1))/15;

ymierz = odczyt_danych_z_txt('Pomiary/skok_50_60');
ymierz = (ymierz-ymierz(1))/10;

ymierz = odczyt_danych_z_txt('Pomiary/skok_65_75');
ymierz = (ymierz-ymierz(1))/10;

kk = length(ymierz);

parametry_pocz = [1, 1, 1, 1];
ogr_dol = [0, 0, 0, 0];  
ogr_gor = [200,200, 50, 12];

% Używamy algorytmu genetycznego
IntCon = 4;  % Td musi być liczbą całkowitą
options = optimoptions('ga', 'Display', 'iter'); % Opcje algorytmu genetycznego

parametry_optymalne = ga(@(parametry) ...
    funkcja_kosztu(parametry, kk, ymierz), 4, [], [], [], [], ...
    ogr_dol, ogr_gor, [], IntCon, options);

T1 = parametry_optymalne(1);
T2 = parametry_optymalne(2);
K = parametry_optymalne(3);
Td = parametry_optymalne(4);

disp('Parametry modelu:');
disp(['T1 = ', num2str(T1),';']);
disp(['T2 = ', num2str(T2),';']);
disp(['K = ', num2str(K),';']);
disp(['Td = ', num2str(Td),';']);

y = model(T1,T2,K,Td,kk);

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
