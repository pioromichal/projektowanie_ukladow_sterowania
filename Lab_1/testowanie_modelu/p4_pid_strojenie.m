function [r2, r1, r0] = p4_pid_strojenie(K, Ti, Td, Tp)
r2 = K*Td/Tp;
r1 = K*(Tp/(2*Ti) - (2*Td)/Tp - 1);
r0 = K*(1 + Tp/(2*Ti) + Td/Tp);

end

