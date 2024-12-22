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
