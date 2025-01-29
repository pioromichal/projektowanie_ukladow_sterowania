%% yzad
close all
% Parametry symulacji
T_s = 1; % Okres próbkowania (sekundy)
T_timer = 300; % Czas trwania timera (sekundy)
samples = 1200; % Liczba próbek symulacji

% Inicjalizacja zmiennych
y_pp1 = 35.2; % Wartość początkowa procesu 1
y_pp2 = 37; % Wartość początkowa procesu 2

y_zad1 = zeros(1, samples); % Wartości zadane dla procesu 1
y_zad2 = zeros(1, samples); % Wartości zadane dla procesu 2

y_zad1(1:300)=y_pp1; y_zad1(301:600)=y_pp1+15; y_zad1(601:900)=y_pp1+15;y_zad1(901:1200)=y_pp1;
y_zad2(1:300)=y_pp2; y_zad2(301:600)=y_pp2; y_zad2(601:900)=y_pp2+15;y_zad2(901:1200)=y_pp2+15;


% Wizualizacja wyników
figure; hold on; grid on; grid minor;
plot(1:samples, y_zad1,  'DisplayName', 'Proces 1: y\_zad', LineWidth=0.75);
plot(1:samples, y_zad2,  'DisplayName', 'Proces 2: y\_zad', LineWidth=0.75);
xticks(0:300:samples); % Znaczniki na osi X co 300
xlabel('Czas [s]');
ylabel('Wartości zadane');
% title('Symulacja wartości zadanych (y\_zad)');
legend('Location', 'south');
exportgraphics(gcf, 'Wykresy/automat_yzad.pdf', 'ContentType', 'vector');

%% pp

load("Pomiary\punkt_pracy.mat")

y1 = y1/100;
y2 = y2/100;

figure; hold on; grid on; grid minor;
plot(y1(1:600),  'DisplayName', 'Proces 1', LineWidth=0.75);
plot(y2(1:600),  'DisplayName', 'Proces 2', LineWidth=0.75);
% xticks(0:300:samples); % Znaczniki na osi X co 300
xlabel('Czas [s]');
ylabel('y');
% title('Symulacja wartości zadanych (y\_zad)');
legend('Location', 'best');
exportgraphics(gcf, 'Wykresy/punkt_pracy.pdf', 'ContentType', 'vector');

%% mechanizm zabezpieczający

load("Pomiary\zabezpieczenie_pid.mat")

% y1 = y1/100;
% y2 = y2/100;
t=50:224;
colors=lines(2);

figure; hold on; grid on; grid minor;
plot(y1(t),'Color',colors(1,:));
plot(yz1(t),'--','Color',colors(1,:));
plot(y2(t),'Color',colors(2,:));
plot(yz2(t),'--','Color',colors(2,:));
xlabel('Czas [s]');
ylabel('y');
legend('y1','y1_{zad}','y2','y1_{zad}', Location='north');
exportgraphics(gcf, 'Wykresy/mech_zabezp_y.pdf', 'ContentType', 'vector');

figure; hold on; grid on; grid minor;
legend('u1','u2', Location='best');
plot(u1(t));plot(u2(t));
xlabel('Czas [s]');
ylabel('u');
legend('u1','u2', Location='best');
exportgraphics(gcf, 'Wykresy/mech_zabezp_u.pdf', 'ContentType', 'vector');


%%

% Dane z tabeli
D = [0, 100, 110, 125, 150, 200];              % Wartości D
ilosc_rejestrow = [2, 600, 660, 750, 900, 1200]; % Ilość rejestrów
dlugosc_cyklu = [2, 11.1, 12.1, 13.3, 15.5, 20.1]; % Długość cyklu (ms)

% Tworzenie wykresu z dwiema osiami
figure;
xlim([-1 201]);

% Oś prawa - Ilość rejestrów
yyaxis right;
plot(D, ilosc_rejestrow, '-o', 'LineWidth', 1.5);
ylabel('Ilość rejestrów');
ylim([0 1600]); % Zakres dla osi prawej

% Oś lewa - Długość cyklu
yyaxis left;
plot(D, dlugosc_cyklu, '-s', 'LineWidth', 1.5);
ylabel('Długość cyklu (ms)');
ylim([0 22]); % Zakres dla osi lewej

% Ustawienia osi i tytułu
xlabel('D');
% title('Parametry komunikacyjne');
grid on;
legend({'Długość cyklu', 'Ilość rejestrów'}, 'Location', 'southeast');

% Eksport wykresu
exportgraphics(gcf, 'Wykresy/cykl_rejestry.pdf', 'ContentType', 'vector');