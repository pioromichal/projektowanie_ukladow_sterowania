clear; close all;

[y,u] = p3_odpowiedz_skokowa(150);

% wyniki symulacji
figure; stairs(u); hold on; stairs(y);
ylabel('u'); xlabel('k'); grid on; grid minor;
