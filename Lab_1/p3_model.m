function y = p3_model(T1,T2,K,Td,kk,u)
alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);

a1 = - alfa1 - alfa2;
a2 = alfa1*alfa2;

b1 = (K/(T1-T2))*(T1*(1-alfa1)-T2*(1-alfa2));
b2 = (K/(T1-T2))*(alfa1*T2*(1-alfa2)-alfa2*T1*(1-alfa1));

y = zeros(kk,1);
for k=15:kk
    y(k) = b1*u(k-Td-1) + b2*u(k-Td-2) - a1*y(k-1) - a2*y(k-2);
end
end