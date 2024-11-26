function [ys]=dmc_odp_jednostkowa_rozm(kk)
K = [0.38024, 0, 0];
Td = [6, 0, 0];
T1 = [82.0474, 0, 0];
T2 = [3.3333, 0, 0];
for i=1:3
    ys(:,i) = model(T1(i),T2(i),K(i),Td(i),kk);
end
end