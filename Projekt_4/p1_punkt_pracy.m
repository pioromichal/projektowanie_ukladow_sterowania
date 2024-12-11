clear; close all;
kk=200; % koniec symulacji
u1(1:kk)=0; u2(1:kk)=0; u3(1:kk)=0; u4(1:kk)=0; 
y1(1:4)=0; y2(1:4)=0; y3(1:4)=0;
Tp=0.5;
time=0:Tp:Tp*(kk-1);

% główna pętla symulacyjna
for k=5:kk 
    % symulacja obiektu
    [y1(k), y2(k), y3(k)] = symulacja_obiektu15y_p4(u1(k-1), u1(k-2), u1(k-3), u1(k-4), ...
    u2(k-1), u2(k-2), u2(k-3), u2(k-4), u3(k-1), u3(k-2), u3(k-3), u3(k-4), ...
    u4(k-1), u4(k-2), u4(k-3), u4(k-4), y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
    y2(k-1), y2(k-2), y2(k-3), y2(k-4), y3(k-1), y3(k-2), y3(k-3), y3(k-4));
end

% Tworzenie wykresu dla u
figure;
subplot(2, 2, 1);
plot(time, u1, 'b');
title('Wejście u1');
xlabel('Czas [s]'); ylabel('u1');

subplot(2, 2, 2);
plot(time, u2, 'r');
title('Wejście u2');
xlabel('Czas [s]'); ylabel('u2');

subplot(2, 2, 3);
plot(time, u3, 'g');
title('Wejście u3');
xlabel('Czas [s]'); ylabel('u3');

subplot(2, 2, 4);
plot(time, u4, 'k');
title('Wejście u4');
xlabel('Czas [s]'); ylabel('u4');

exportgraphics(gcf, 'Wykresy/p1_test_u.pdf', 'ContentType', 'vector');
close;

% Tworzenie wykresu dla y
figure;
subplot(3, 1, 1);
plot(time, y1, 'b');
title('Wyjście y1');
xlabel('Czas [s]'); ylabel('y1');

subplot(3, 1, 2);
plot(time, y2, 'r');
title('Wyjście y2');
xlabel('Czas [s]'); ylabel('y2');

subplot(3, 1, 3);
plot(time, y3, 'g');
title('Wyjście y3');
xlabel('Czas [s]'); ylabel('y3');


% Zapis wykresu jako plik PDF
exportgraphics(gcf, 'Wykresy/p1_test_y.pdf', 'ContentType', 'vector');
close;