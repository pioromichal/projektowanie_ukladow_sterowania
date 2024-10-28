function [ys]=odp_jedn(kk)
K = 0.38024;
Td = 6;
T1 = 82.0474;
T2 = 3.3333;
u(1:kk)=1;
ys = p3_model(T1,T2,K,Td,kk,u);

end