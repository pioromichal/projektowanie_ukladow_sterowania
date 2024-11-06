function [ys]=odp_jedn_zak(kk)
K = 0.2214;
Td = 2;
T1 = 9.0581;
T2 = 77.7947;
u(1:kk)=1;
ys = p3_model(T1,T2,K,Td,kk,u);

end