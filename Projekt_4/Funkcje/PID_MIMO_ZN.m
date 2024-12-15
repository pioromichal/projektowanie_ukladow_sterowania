function [K,Ti,Td] = PID_MIMO_ZN(K_u,T_u)
    K = 0.6 * K_u;
    Ti = 0.5 * T_u;
    Td = 0.125 * T_u;
end

