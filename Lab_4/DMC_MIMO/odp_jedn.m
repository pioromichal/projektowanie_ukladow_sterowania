function [S, s11, s21, s12, s22]=odp_jedn(kk)

T1 = 17.3664;
T2 = 3.7951;
K = 0.32146;
Td = 2;

s11 = model(T1,T2,K,Td,kk);

T1 = 17.0074;
T2 = 12.1618;
K = 0.11288;
Td = 2;

s21 = model(T1,T2,K,Td,kk);

T1 = 6.4912;
T2 = 26.0284;
K = 0.18582;
Td = 0;

s12 = model(T1,T2,K,Td,kk);

T1 = 5.7191;
T2 = 17.6787;
K = 0.3983;
Td = 3;

s22 = model(T1,T2,K,Td,kk);


S = zeros(2,2,kk);


S(1,1,:)=s11;
S(1,2,:)=s12;
S(2,1,:)=s21;
S(2,2,:)=s22;


end