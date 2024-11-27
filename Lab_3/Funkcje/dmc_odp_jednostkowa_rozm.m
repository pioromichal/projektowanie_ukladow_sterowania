function [ys]=dmc_odp_jednostkowa_rozm(kk)
K = [0.44229, 0.32123, 0.22986];
Td = [7, 7, 7];
T1 = [10.2021, 6.8717, 15.3719];
T2 = [76.437, 110.917, 77.9063];
for i=1:3
    ys(:,i) = model(T1(i),T2(i),K(i),Td(i),kk);
end
end