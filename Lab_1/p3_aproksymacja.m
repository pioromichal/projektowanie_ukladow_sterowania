clear;
parametry_pocz = [1, 1, 1, 1];


% zaladowac prawdziwe ymierz i umierz

% ymierz = symulacja_pomiarow(kk,u)';
% ymierz=ones(kk,1);

% kk = 536;
% u(1:kk)=1;
% ymierz = odczyt_danych_z_txt("pomiary/skok_1_30.txt");
% ymierz = (ymierz-32.81)/5;

% kk = 482;
% u(1:kk)=1;
% ymierz = odczyt_danych_z_txt("pomiary/skok_2_40.txt");
% ymierz = (ymierz-33)/15;

kk = 460;
u(1:kk)=1;
ymierz = odczyt_danych_z_txt("pomiary/skok_3_35.txt");
ymierz = (ymierz-32.68)/10;

% kk = 440;
% u(1:kk)=1;
% ymierz = odczyt_danych_z_txt("pomiary/skok_4_45.txt");
% ymierz = (ymierz-32.62)/20;


ogr_dol = [1, 1, 0, 0];  
ogr_gor = [120, 120, 50, 12];

% Używamy algorytmu genetycznego
IntCon = 4;  % Td musi być liczbą całkowitą
options = optimoptions('ga', 'Display', 'iter'); % Opcje algorytmu genetycznego

parametry_optymalne = ga(@(parametry) p3_funkcja_kosztu(parametry, kk, u, ymierz), 4, [], [], [], [], ogr_dol, ogr_gor, [], IntCon, options);

T1 = parametry_optymalne(1);
T2 = parametry_optymalne(2);
K = parametry_optymalne(3);
Td = parametry_optymalne(4);

disp('Parametry modelu:');
disp(['T1: ', num2str(T1)]);
disp(['T2: ', num2str(T2)]);
disp(['K: ', num2str(K)]);
disp(['Td: ', num2str(Td)]);

y = p3_model(T1,T2,K,Td,kk,u);

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


% Definicja transmitancji
num = K;             % Licznik transmitancji
den = [T1*T2, T1 + T2, 1];  % Mianownik transmitancji: (T1*s + 1)(T2*s + 1)
sys = tf(num, den);  % Tworzenie obiektu transmitancji bez opóźnienia

% Aproksymacja Padé dla opóźnienia
delay = pade(Td, 1); % Aproksymacja Padé pierwszego rzędu dla opóźnienia Td

% Połączenie transmitancji z opóźnieniem
sys_delayed = sys * delay;

figure;
% Symulacja odpowiedzi skokowej
step(sys);
title('Odpowiedź skokowa modelu dwuinercyjnego z opóźnieniem');
xlabel('Czas (s)');
ylabel('Odpowiedź skokowa');
grid on;