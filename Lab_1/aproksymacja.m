function E = aproksymacja_funkcja_kosztu(parametry, kk, ymierz, u)
T1 = parametry(1);
T2 = parametry(2);
K = parametry(3);
Td = parametry(4);

alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);

a1 = - alfa1 - alfa2;
a2 = alfa1*alfa2;

b1 = (K/(T1-T2))*(T1*(1-alfa1)-T2*(1-alfa2));
b2 = (K/(T1-T2))*(alfa1*T2*(1-alfa2)-alfa2*T1*(1-alfa1));

y = zeros(kk,1);
for k=23:kk
    y(k) = b1*u(k-Td-1) + b2*u(k-Td-2) - a1*y(k-1) - a2*y(k-2);
end

E = (ymierz - y)' * (ymierz - y);

end

clear;
parametry_pocz = [1, 1, 1, 1];
kk = 300;
% zaladowac prawdziwe ymierz i umierz
ymierz=ones(kk,1);
umierz=ones(kk,1);

ogr_dol = [0.01, 0.01, 0, 0];  
ogr_gor = [60, 60, 50, 20];

% Używamy algorytmu genetycznego
IntCon = 4;  % Td musi być liczbą całkowitą
options = optimoptions('ga', 'Display', 'iter'); % Opcje algorytmu genetycznego

parametry_optymalne = ga(@(parametry) aproksymacja_funkcja_kosztu(parametry, kk, ymierz, umierz), 4, [], [], [], [], ogr_dol, ogr_gor, [], IntCon, options);

T1 = parametry_optymalne(1);
T2 = parametry_optymalne(2);
K = parametry_optymalne(3);
Td = parametry_optymalne(4);

disp('Optymalne parametry DMC:');
disp(['T1: ', num2str(T1)]);
disp(['T2: ', num2str(T2)]);
disp(['K: ', num2str(K)]);
disp(['Td: ', num2str(Td)]);

% [y, u] = p4_funkcja_dmc(kk, yzad, N, Nu, D, lambda);
% 
% % wyniki symulacji
% figure; stairs(u);
% ylabel('u'); xlabel('k'); grid on; grid minor;
% % close;
% 
% figure; stairs(y); hold on; stairs(yzad,':');
% xlabel('k'); ylabel('y'); grid on; grid minor;
% legend('Wyjście', 'Wartość zadana');
% % close;

% E = (ymierz-y)'*(ymierz-y);
% disp(['E: ', num2str(E)]);