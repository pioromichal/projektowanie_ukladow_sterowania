function [ys]=skok_jednostkowy_fun(kk)

Ko = 0.38024;
To = 6;
T1 = 82.0474;
T2 = 3.3333;
[a1, a0, b1, b0] = parametry_rownania_roznicowego(Ko,To,T1,T2);

Ypp = 32.68; Upp = 25;
% warunki początkowe
u(1:11)=Upp; y(1:11)=Ypp;

for k=12:kk 
    y(k) = Ypp -a1*(y(k-1)-Ypp)-a0*(y(k-2)-Ypp) + 1*(b1*(u(k-10)-Upp) + b0*(u(k-11)-Upp));
    
end

ys=y;
end