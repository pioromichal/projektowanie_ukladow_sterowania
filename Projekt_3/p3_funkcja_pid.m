function [y, u] = p3_funkcja_pid(kk, yzad, r2, r1, r0)
%P4_FUNKCJA_PID Summary of this function goes here
%   Detailed explanation goes here

% wartości ograniczeń
umin = -1; umax=1;

% inicjalizacja
u(1:kk)=0; y(1:kk)=0; e(1:kk)=0;

% warunki początkowe
u(1:6)=0; y(1:6)=0;

% główna pętla symulacyjna
for k=7:kk
    % symulacja obiektu
    y(k)=symulacja_obiektu15y_p3(u(k-5), u(k-6), y(k-1), y(k-2));

    % uchyb regulacji
    e(k)=yzad(k)-y(k);

    % sygnał sterujący regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);

    % ograniczenia wartości sygnału sterującego
    if u(k) < umin
        u(k) = umin;
    elseif u(k) > umax
        u(k) = umax;
    end
end

end

