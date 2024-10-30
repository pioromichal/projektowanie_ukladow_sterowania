function [y, u] = p4_funkcja_pid(kk, yzad, r2, r1, r0)
%P4_FUNKCJA_PID Summary of this function goes here
%   Detailed explanation goes here

% wartości ograniczeń
umin = 0.9; umax=1.5;
dumax = 0.05;

% inicjalizacja
u(1:kk)=0; y(1:kk)=0; e(1:kk)=0;

% warunki początkowe
u(1:11)=1.2; y(1:11)=2;

% główna pętla symulacyjna
for k=12:kk
    % symulacja obiektu
    y(k)=symulacja_obiektu15y_p1(u(k-10),u(k-11),y(k-1),y(k-2));

    % uchyb regulacji
    e(k)=yzad(k)-y(k);

    % sygnał sterujący regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);

    % ograniczenia przyrostu sygnału sterującego
    delta_u = u(k)-u(k-1);
    if  delta_u < -dumax
        u(k) = u(k-1) - dumax;
        % disp(['-du ' num2str(k)]);
    elseif delta_u > dumax
        u(k) = u(k-1) + dumax;
        % disp(['du ' num2str(k)]);
    end

    % ograniczenia wartości sygnału sterującego
    if u(k) < umin
        u(k) = umin;
        % disp(['umin ' num2str(k)]);
    elseif u(k) > umax
        u(k) = umax;
        % disp(['umax ' num2str(k)]);
    end
end

end

