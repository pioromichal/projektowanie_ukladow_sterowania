clear;

% konfiguracja wykresu
figure(1);
h1 = plot(nan, nan, 'DisplayName', 'u'); % Wykres dla pomiaru 1
xlabel('Czas (s)');
ylabel('u');
title('u');
legend('show');
figure(2);
h2 = plot(nan, nan, 'DisplayName', 'y'); % Wykres dla pomiaru 2
hold on;
h3 = plot(nan, nan, 'DisplayName', 'y_zad'); % Wykres dla pomiaru 3
xlabel('Czas (s)');
ylabel('y');
title('y i y_zad');
legend('show');

kk = 600;
yzad = 35;
yzad = yzad*ones(kk,1);
umin = 0; umax=100;

K = 0.1;
Ti = 5;
Td = 0;
[r2, r1, r0] = p4_pid_strojenie_2(K,Ti,Td,1);

% warunki początkowe
u(1:kk)=0; y(1:kk)=0; e(1:kk)=0;

% główna pętla symulacyjna
for k=1:kk
    % symulacja obiektu
    y(k) = readMeasurements (1);

    % uchyb regulacji
    e(k)=yzad(k)-y(k);

    % sygnał sterujący regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);

    if u(k) < umin
        u(k) = umin;
        disp(['osiagnieto umin ' num2str(k)]);
    elseif u(k) > umax
        u(k) = umax;
        disp(['osiagnieto umax ' num2str(k)]);
    end

    sendControls ([ 1 , 5 ] , [ 50 , u(k) ]) ; % kolejno W1 i G1

    % aktualizacja wykresu
    figure(1);
    set(h1, 'YData', u, 'XData', 1:t);
    figure(2);
    set(h2, 'YData', y, 'XData', 1:t);
    set(h3, 'YData', yzad, 'XData', 1:t);

    waitForNewIteration () ; % wait for new iteration
end

% zapisywanie danych do pliku, tak aby nie nadpisywało starych pomiarow
i = 1;
while 1
    filename1 = ['pomiary/p4_pid_' num2str(i) '_y.txt'];
    filename2 = ['pomiary/p4_pid_' num2str(i) '_u.txt'];

    if exist(filename1, 'file') == 2 || exist(filename2, 'file') == 2
        i = i + 1;
    else
        zapisz_dane_do_txt(y, filename1);
        zapisz_dane_do_txt(u, filename2);
        break;
    end
end

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;
% close;

figure; stairs(y); hold on; stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;
legend('Wyjście', 'Wartość zadana');
% close;

E = (yzad-y')'*(yzad-y');
disp(E);