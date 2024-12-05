function [y,u] = p3_odpowiedz_skokowa(kk, Ypp, dU)
%P3_ODPOWIEDZ_SKOKOW Summary of this function goes here
%   Detailed explanation goes here

Td = 4;

kk = kk + Td + 3;

Upp = znajdz_u_do_odp_DMC(Ypp);

u(1:Td+2)=Upp; u(Td+3:kk)=Upp+dU; y(1:kk)=Ypp;

% główna pętla symulacyjna
for k=3+Td:kk
    % symulacja obiektu
    y(k) = symulacja_obiektu15y_p3(u(k-5), u(k-6), y(k-1), y(k-2));
end

%normalizacja odpowiedzi skokowej
u=(u-Upp)/dU;
y=(y-Ypp)/dU;
u(1:Td+3)=[];y(1:Td+3)=[];
end

