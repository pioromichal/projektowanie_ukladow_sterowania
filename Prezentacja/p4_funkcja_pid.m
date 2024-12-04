function [y, u] = p4_funkcja_pid(kk, yzad, r2, r1, r0)
%P4_FUNKCJA_PID Summary of this function goes here
%   Detailed explanation goes here

% inicjalizacja
u(1:kk)=0; y(1:kk)=0; e(1:kk)=0; z(1:kk)=0;

% warunki początkowe
u(1:7)=0; y(1:7)=0;

% główna pętla symulacyjna
for k=8:kk
    % symulacja obiektu
    y(k)=symulacja_obiektu15y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));

    % uchyb regulacji
    e(k)=yzad(k)-y(k);

    % sygnał sterujący regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
end

end

