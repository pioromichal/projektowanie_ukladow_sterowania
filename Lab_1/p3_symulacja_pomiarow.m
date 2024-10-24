function y = p3_symulacja_pomiarow(kk, u)

% Ko=5,1, To=10, T1=1,87, T2=5,37

%             0.2009 z + 0.158
% z^(-5) * ----------------------
%          z^2 - 1.416 z + 0.4863

y(1:12)=0; 

for k=13:kk
    y(k) = 1.416*y(k-1) - 0.4863*y(k-2) + 0.2009*u(k-11) + 0.158*u(k-12);
end
end