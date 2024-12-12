% clear;

% zaladowac prawdziwe ymierz
load('D:\Radek\STUDIA\2024Z\PUST\LAB\Lab_4\Pomiary\SKOK_U1_+15.mat')

ys11 = y1(42+1:end);
ys21 = y2(42+1:end);

load('D:\Radek\STUDIA\2024Z\PUST\LAB\Lab_4\Pomiary\SKOK_U2_+15.mat')

ys12 = y1(45+1:end);
% ys12(1:10)=ys12(11);
ys22 = y2(45+1:end);


ymierz = ys22(1:4:end);
ymierz = (ymierz-ymierz(1))/15;

kk = length(ymierz);

parametry_pocz = [1, 1, 1, 1];
ogr_dol = [0, 0, 0, 0];  
ogr_gor = [200,200, 50, 12];

% Używamy algorytmu genetycznego
IntCon = 4;  % Td musi być liczbą całkowitą
options = optimoptions('ga'); % Opcje algorytmu genetycznego

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
