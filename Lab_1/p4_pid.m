clear;
addpath ('D:\ SerialCommunication ') ; % add a path
initSerialControl COM4 % initialise com port

% konfiguracja wykresu
figure('Position', [100, 100, 800, 600]); % Tworzenie większej figury

% Pierwszy subplot dla wykresu 'u'
subplot(2, 1, 1);
h1 = plot(nan, nan, 'DisplayName', 'u');
xlabel('Czas (s)');
ylabel('u');
title('u');
legend('show');
% Drugi subplot dla wykresów 'y' i 'y_zad'
subplot(2, 1, 2);
h2 = plot(nan, nan, 'DisplayName', 'y');
hold on;
h3 = plot(nan, nan, 'DisplayName', 'y_zad'); 
xlabel('Czas (s)');
ylabel('y');
title('y i y_zad');
legend('show');

kk = 3000;
yzad(1:450) = 35; yzad(451:900) = 40; yzad(901:kk)=33;
umin = 0; umax=100;
% 
% K = 15.3505;
% Ti = 45;
% Td = 1.3602;
K = 11;
Ti = 80;
Td = 0.3;
[r2, r1, r0] = p4_pid_strojenie_2(K,Ti,Td,1);

% warunki początkowe
u(1:2)=25; y(1:2)=32.68; e(1:kk)=0;
u(3:kk)=0; y(3:kk)=0;


% główna pętla symulacyjna
for k=3:kk
    % symulacja obiektu
    y(k) = readMeasurements(1);

    % uchyb regulacji
    e(k)=yzad(k)-y(k);

    % sygnał sterujący regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);

    if u(k) < umin
        u(k) = umin;
        % disp(['osiagnieto umin ' num2str(k)]);
    elseif u(k) > umax
        u(k) = umax;
        % disp(['osiagnieto umax ' num2str(k)]);
    end

    sendControls ([ 1 , 5 ] , [ 50 , int64(u(k)) ]) ; % kolejno W1 i G1

    % aktualizacja wykresu
    set(h1, 'YData', u(1:k), 'XData', 1:k);
    set(h2, 'YData', y(1:k), 'XData', 1:k);
    set(h3, 'YData', yzad(1:k), 'XData', 1:k);
    drawnow;

    waitForNewIteration () ; % wait for new iteration
end

% zapisywanie danych do pliku, tak aby nie nadpisywało starych pomiarow
i = 1;
while 1
    filename1 = ['p4_pid_' num2str(i) '_y'];
    filename2 = ['p4_pid_' num2str(i) '_u'];

    if exist(['pomiary/'  filename1  '.txt'], 'file') == 2 || exist(['pomiary/'  filename2  '.txt'], 'file') == 2
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

E = (yzad-y)*(yzad-y)';
disp(E);