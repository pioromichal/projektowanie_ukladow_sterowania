function [a1, a0, b1, b0] = parametry_rownania_roznicowego(Ko,To,T1,T2)
%ROWNANIE_ROZNICOWE Summary of this function goes here
%   Detailed explanation goes here
% Ko = 0.010881;
% To = 9;
% T1 = 83.3474;
% T2 = 2.4876;
Tp = 1;

s = tf('s'); % określenie transmitancji jako wyrażenia z 's'
NUM = Ko*exp(-To*s);
DEN = (T1*s+1)*(T2*s+1);

Gs = NUM/DEN;
Gz = c2d(Gs, Tp, 'zoh');

b1 = Gz.Numerator{1}(2);
b0 = Gz.Numerator{1}(3);
a1 = Gz.Denominator{1}(2);
a0 = Gz.Denominator{1}(3);

% disp("y(k) = " + num2str(-a1) + "*y(k-1) "+num2str(-a0)+"*y(k-2) + "+ ...
    % num2str(b1)+"*u(k-"+num2str(To+1)+") + "+num2str(b0)+"*u(k-"+num2str(To+2)+");")
end

