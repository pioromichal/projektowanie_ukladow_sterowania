addpath('Funkcje')

kk = 250;


U = zeros(4, kk); % macierz dla u1, u2, u3, u4 
y1(1:4)=0; y2(1:4)=0; y3(1:4)=0;
y1_zad=1; y2_zad=1; y3_zad=1;
Y_zad=[y1_zad;y2_zad;y3_zad];


D=10; N=D; Nu=N; 
lambda=[1 2 3 4]; psi=[1 2 3];

S=p2_odpowiedzi_skokowe(250);

[Ke,Ku]=DMC_MIMO_offline(S,D,N,Nu,lambda,psi);

clear S N Nu lambda psi y1_zad y2_zad y3_zad;

dUp=zeros(4,D-1);
for k=5:kk
    [y1(k), y2(k), y3(k)] = symulacja_obiektu15y_p4( ...
            U(1, k-1), U(1, k-2), U(1, k-3), U(1, k-4), ...
            U(2, k-1), U(2, k-2), U(2, k-3), U(2, k-4), ...
            U(3, k-1), U(3, k-2), U(3, k-3), U(3, k-4), ...
            U(4, k-1), U(4, k-2), U(4, k-3), U(4, k-4), ...
            y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
            y2(k-1), y2(k-2), y2(k-3), y2(k-4), ...
            y3(k-1), y3(k-2), y3(k-3), y3(k-4));
    Y=[y1(k);y2(k);y3(k)];
    dU=DMC_MIMO_dU(Y,Y_zad,Ke,Ku,dUp);
    U(:,k)=U(:,k-1)+dU;
    dUp(:,2:end)=dUp(:,1:end-1);
    dUp(:,1)=dU;
end

figure;
plot(1:kk, y1); hold on;
plot(1:kk, y2);
plot(1:kk, y3);
xlabel('Krok czasowy');
ylabel('Wartości wyjściowe');
legend('y1', 'y2', 'y3');
title('Wykres wartości wyjściowych');
grid on;

% Wykres wartości sterowania
figure;
plot(1:kk, U(1,:)); hold on;
plot(1:kk, U(2,:));
plot(1:kk, U(3,:));
plot(1:kk, U(4,:));
xlabel('k');
ylabel('Wartości sterowania');
legend('u1', 'u2', 'u3', 'u4');
title('Wykres wartości sterowania');
grid on;