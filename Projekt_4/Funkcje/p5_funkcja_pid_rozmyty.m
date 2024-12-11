function [y, u] = p5_funkcja_pid_rozmyty(kk, yzad, parametry_pid, centra_rozmycia, z_switch)
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

    mi = fun_przyn_trap(y(k), centra_rozmycia, z_switch);
    % disp(mi)

    ur = zeros(1, length(parametry_pid));
    for i=1:length(parametry_pid)
        r2 = parametry_pid{i}{1};
        r1 = parametry_pid{i}{2};
        r0 = parametry_pid{i}{3};
        ur(i) = r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
    end

    % sygnał sterujący regulatora PID
    u(k) = mi * ur';

    % ograniczenia wartości sygnału sterującego
    if u(k) < umin
        u(k) = umin;
    elseif u(k) > umax
        u(k) = umax;
    end
end

end

