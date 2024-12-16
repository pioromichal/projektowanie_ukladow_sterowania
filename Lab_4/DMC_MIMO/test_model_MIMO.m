kk=1000;

Upp=[25,30];
Ypp=[35,37];

% 1 -> 1
T1(1,1) = 17.3664;
T2(1,1) = 3.7951;
K(1,1) = 0.32146;
Td(1,1) = 2;

% 1 -> 2
T1(2,1)= 17.0074;
T2(2,1) = 12.1618;
K(2,1) = 0.11288;
Td(2,1) = 2;

% 2 -> 1
T1(1,2) = 6.4912;
T2(1,2) = 26.0284;
K(1,2) = 0.18582;
Td(2,2) = 0;

% 2 -> 2
T1(2,2) = 5.7191;
T2(2,2) = 17.6787;
K(2,2) = 0.3983;
Td(2,2) = 3;
[y,u] = model_MIMO(T1,T2,K,Td,kk,Upp,Ypp);


% Wykresy wartości wyjściowych
t = 0:kk;

figure;
subplot(2, 1, 1);
plot(t, y(1, :)); hold on;
title('Wyjście y1');
xlabel('Krok czasowy');
ylabel('y1');
grid on;

subplot(2, 1, 2);
plot(t, y(2, :));
title('Wyjście y2');
xlabel('Krok czasowy');
ylabel('y2');
grid on;

% Wykresy wartości wejściowych
figure;
subplot(2, 1, 1);
plot(t, u(1, :));
title('Wejście u1');
xlabel('Krok czasowy');
ylabel('u1');
grid on;

subplot(2, 1, 2);
plot(t, u(2, :));
title('Wejście u2');
xlabel('Krok czasowy');
ylabel('u2');
grid on;