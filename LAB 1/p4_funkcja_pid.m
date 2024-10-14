function [y, u] = p4_funkcja_pid(kk, yzad, Kk, Tk)
%P4_FUNKCJA_PID Summary of this function goes here
%   Detailed explanation goes here

% inicjalizacja
dumax = 0.05;
umin = 0.3; umax=0.7;

[r2, r1, r0] = p4_pid_strojenie(Kk,Tk,0.5);

% warunki początkowe
u(1:11)=0.5; y(1:11)=4; e(1:11)=0;
% yzad(1:9)=4; yzad(10:kk)=i_yzad;

% główna pętla symulacyjna
for k=12:kk 
    % symulacja obiektu
    y(k) = symulacja_obiektu1y_p1(u(k-10), u(k-11), y(k-1), y(k-2));

    % uchyb regulacji
    e(k)=yzad(k)-y(k);

    % sygnał sterujący regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);

    delta_u = u(k)-u(k-1);
    if  delta_u < -dumax
        u(k) = u(k-1) - dumax;
%         disp(['-du ' num2str(k)]);
    elseif delta_u > dumax
        u(k) = u(k-1) + dumax;
%         disp(['du ' num2str(k)]);
    end

    if u(k) < umin
        u(k) = umin;
%         disp(['umin ' num2str(k)]);
    elseif u(k) > umax
        u(k) = umax;
%         disp(['umax ' num2str(k)]);
    end
end

end

