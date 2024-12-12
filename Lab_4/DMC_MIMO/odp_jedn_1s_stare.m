function [S, s11, s21, s12, s22]=odp_jedn_1s_stare(kk)

T1 = 11.1223;
T2 = 70.5568;
K = 0.32167;
Td = 9;

s11 = model(T1,T2,K,Td,kk);

T1 = 24.1911;
T2 = 92.5771;
K = 0.11495;
Td = 12;

s21 = model(T1,T2,K,Td,kk);

T1 = 91.8898;
T2 = 33.3278;
K = 0.17571;
Td = 3;

s12 = model(T1,T2,K,Td,kk);

T1 = 60.8224;
T2 = 28.878;
K = 0.39478;
Td = 11;

s22 = model(T1,T2,K,Td,kk);


S = zeros(2,2,kk);


S(1,1,:)=s11;
S(1,2,:)=s12;
S(2,1,:)=s21;
S(2,2,:)=s22;


end