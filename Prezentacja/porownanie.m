clear all;

Kkryt = 3.168;
Tkryt = 20;
Tp = 1;
kk = 100;

u1(1:7)=0;
y1(1:7)=0;
z(1:kk)=0;
yzad(1:kk)=1;
e(1:kk)=0;

%% Ziegler-Nichols
K = 0.6*Kkryt;
Ti = Tkryt/2;
Td = Tkryt/8;
r2 = K*Td/Tp;
r1 = K*(Tp/(2*Ti) - (2*Td)/Tp - 1);
r0 = K*(1 + Tp/(2*Ti) + Td/Tp);
for k=8:kk
    y1(k)=symulacja_obiektu15y_p2(u1(k-6), u1(k-7), z(k-3), z(k-4), y1(k-1), y1(k-2));
    e(k)=yzad(k)-y1(k);
    u1(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u1(k-1);
end

%% Cohen-Coon
clear z yzad e K Ti Td r2 r1 r0

u2(1:7)=0;
y2(1:7)=0;
z(1:kk)=0;
yzad(1:kk)=1;
e(1:kk)=0;

Ku=2.007;
L=5;
T=20;

K = (1 / Ku) * (T / L) * ((4/3)+L/(4*T));
Ti = L * ((32 + 6 * (L / T)) / (13 + 8 * (L / T)));
Td = (L * 4) / (11 + 2 * (L / T));
r2 = K*Td/Tp;
r1 = K*(Tp/(2*Ti) - (2*Td)/Tp - 1);
r0 = K*(1 + Tp/(2*Ti) + Td/Tp);

for k=8:kk
    y2(k)=symulacja_obiektu15y_p2(u2(k-6), u2(k-7), z(k-3), z(k-4), y2(k-1), y2(k-2));
    e(k)=yzad(k)-y2(k);
    u2(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u2(k-1);
end

%% Armstrong

clear z yzad e K Ti Td r2 r1 r0

u3(1:7)=0;
y3(1:7)=0;
z(1:kk)=0;
yzad(1:kk)=1;
e(1:kk)=0;

K = (1/Ku)*(1+L/(2*T));
Ti = T+L;
Td = (T*L)/(T+2*L);

r2 = K*Td/Tp;
r1 = K*(Tp/(2*Ti) - (2*Td)/Tp - 1);
r0 = K*(1 + Tp/(2*Ti) + Td/Tp);

for k=8:kk
    y3(k)=symulacja_obiektu15y_p2(u3(k-6), u3(k-7), z(k-3), z(k-4), y3(k-1), y3(k-2));
    e(k)=yzad(k)-y3(k);
    u3(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u3(k-1);
end

%% Algorytm genetyczny
clear z yzad e K Ti Td r2 r1 r0

u4(1:7)=0;
y4(1:7)=0;
z(1:kk)=0;
yzad(1:kk)=1;
e(1:kk)=0;

% r0 = 5.8294;
% r1 = -10.0606;
% r2 = 4.3124;
% 
K = 1.4666;
Ti = 15;
Td = 1;

K = 1.4764;
Ti = 18.1739;
Td = 2.9211;

r2 = K*Td/Tp;
r1 = K*(Tp/(2*Ti) - (2*Td)/Tp - 1);
r0 = K*(1 + Tp/(2*Ti) + Td/Tp);

for k=8:kk
    y4(k)=symulacja_obiektu15y_p2(u4(k-6), u4(k-7), z(k-3), z(k-4), y4(k-1), y4(k-2));
    e(k)=yzad(k)-y4(k);
    u4(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u4(k-1);
end

%% Wyniki 
figure;

% Górny wykres: sygnał wyjściowy
subplot(2, 1, 1); % 2 wiersze, 1 kolumna, 1. wykres
stairs(y1, 'LineWidth',1); hold on; grid on; grid minor;
stairs(y4, 'LineWidth',1); hold on; 
stairs(y3, 'LineWidth',1); hold on; 
stairs(yzad);
title('Sygnał wyjściowy'); 
legend('Z-N',  'Alg. Gen.', 'Arm.','y_{zad}'); 
ylabel('y'); 
xlabel('k');

% Dolny wykres: sygnał wejściowy
subplot(2, 1, 2); % 2 wiersze, 1 kolumna, 2. wykres
stairs(u1, 'LineWidth',1); hold on; grid on; grid minor;
stairs(u4,'--', 'LineWidth',1); hold on; 
stairs(u3,'--', 'LineWidth',1);
title('Sygnał wejściowy'); 
legend('Z-N', 'Alg. Gen.','Arm.'); 
ylabel('u'); 
xlabel('k');ylim([-2 4]);

exportgraphics(gcf, 'wykresy/1.pdf', 'ContentType', 'vector');


figure;
% Górny wykres: sygnał wyjściowy
subplot(2, 1, 1); % 2 wiersze, 1 kolumna, 1. wykres
stairs(y2); hold on; grid on; grid minor;
stairs(yzad);
title('Sygnał wyjściowy'); 
legend('C-C', 'y_{zad}'); 
ylabel('y'); 
xlabel('k');

% Dolny wykres: sygnał wejściowy
subplot(2, 1, 2); % 2 wiersze, 1 kolumna, 2. wykres
stairs(u2);  grid on; grid minor;
title('Sygnał wejściowy'); 
ylabel('u'); 
xlabel('k');
exportgraphics(gcf, 'wykresy/2.pdf', 'ContentType', 'vector');
   
disp(['Z-N:     ' num2str((yzad-y1)*(yzad-y1)')]);
disp(['C-C:     ' num2str((yzad-y2)*(yzad-y2)')])
disp(['Arm:     ' num2str((yzad-y3)*(yzad-y3)')])
disp(['Al. gen: ' num2str((yzad-y4)*(yzad-y4)')])