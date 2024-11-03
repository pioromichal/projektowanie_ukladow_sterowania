function [y, u] = funkcja_pid(kk, yzad, r2, r1, r0)
%P4_FUNKCJA_PID Summary of this function goes here
%   Detailed explanation goes here

% inicjalizacja
umin = 0; umax=100;

% [r2, r1, r0] = p4_pid_strojenie(Kk,Tk,0.5);

Ko = 0.38024;
To = 6;
T1 = 82.0474;
T2 = 3.3333;
[a1, a0, b1, b0] = parametry_rownania_roznicowego(Ko,To,T1,T2);
Ypp = 32.68; Upp = 25;
% warunki początkowe
u(1:11)=25; y(1:11)=32.68; e(1:11)=0;

% główna pętla symulacyjna
for k=12:kk 
    % symulacja obiektu
    y(k) = Ypp -a1*(y(k-1)-Ypp)-a0*(y(k-2)-Ypp) + 1*(b1*(u(k-7)-Upp) + b0*(u(k-8)-Upp));

    % uchyb regulacji
    e(k)=yzad(k)-y(k);

    % sygnał sterujący regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);

%     delta_u = u(k)-u(k-1);
%     if  delta_u < -dumax
%         u(k) = u(k-1) - dumax;
% %         disp(['-du ' num2str(k)]);
%     elseif delta_u > dumax
%         u(k) = u(k-1) + dumax;
% %         disp(['du ' num2str(k)]);
%     end

    if u(k) < umin
        u(k) = umin;
%         disp(['umin ' num2str(k)]);
    elseif u(k) > umax
        u(k) = umax;
%         disp(['umax ' num2str(k)]);
    end
end

end

