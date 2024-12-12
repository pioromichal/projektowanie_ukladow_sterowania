function [r2, r1, r0] = PID_MIMO_offline(K, Ti, Td, Tp)

for i=1:max(size(K))
    r2(i) = K(i)*Td(i)/Tp;
    r1(i) = K(i)*(Tp/(2*Ti(i)) - (2*Td(i))/Tp - 1);
    r0(i) = K(i)*(1 + Tp/(2*Ti(i)) + Td(i)/Tp);

end