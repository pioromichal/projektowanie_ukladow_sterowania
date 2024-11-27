function [ys]=odp_jedn(kk)
T1 = 5.1071;
T2 = 1.9511;
K = 0.99772;
Td = 9;

ys = model(T1,T2,K,Td,kk);

end