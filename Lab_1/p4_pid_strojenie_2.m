function [r2, r1, r0] = p4_pid_strojenie_2(K, Ti, Td, Tp)
%P4_STROJENIE_PID Summary of this function goes here
%   Detailed explanation goes here

% K = 0.6 * Kk;
% Ti = 0.5 * Tk;
% Td = 0.12* Tk;

r2 = K*Td/Tp;
r1 = K*(Tp/(2*Ti) - (2*Td)/Tp - 1);
r0 = K*(1 + Tp/(2*Ti) + Td/Tp);

end

