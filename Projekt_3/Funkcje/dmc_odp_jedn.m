function [ys]=dmc_odp_jedn(kk)
K = 0.38024;
Td = 6;
T1 = 82.0474;
T2 = 3.3333;

ys = model(T1,T2,K,Td,kk);

end