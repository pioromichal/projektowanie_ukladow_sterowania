clear; load("wsp_modelu.mat");

kk = 1000;
kp = max(Td(:)) + 3;

Upp=[25,30];
Ypp=[35,37];

% TODO PID_offline

u = Upp' * ones(1, kk);
y = Ypp' * ones(1, kk);
%%
for k = kp:kk
for i = 1:2
    y(i, k) = b1(i,1) * (u(1, k - Td(i,1) - 1) - Upp(1)) + b1(i,2) * (u(2, k - Td(i,2) - 1) - Upp(2)) ...
        + b2(i,1) * (u(1, k - Td(i,1) - 2) - Upp(1)) + b2(i,2) * (u(2, k - Td(i,2) - 2) - Upp(2)) ...
        - a1(i) * (y(i, k-1) - Ypp(i)) - a2(i) * (y(i, k-2) - Ypp(i)) + Ypp(i);
end


% TODO PID online

end


%%
% Wykresy wartości wyjściowych
t = 1:kk;

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