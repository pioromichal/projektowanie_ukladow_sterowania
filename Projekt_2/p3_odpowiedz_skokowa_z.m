function [y,u] = p3_odpowiedz_skokowa_z(kk)
kk = kk +1;
Ypp=0; Zpp=0; dZ=1;

z(1:kk)=Zpp+dZ; y(1:kk)=0; u(1:kk)=0;

% główna pętla symulacyjna
for k=8:kk
    % symulacja obiektu
    y(k) = symulacja_obiektu15y_p2(u(k-6), u(k-7), z(k-3), z(k-4), y(k-1), y(k-2));
end

%normalizacja odpowiedzi skokowej
u=(u-Zpp)/dZ;
y=(y-Ypp)/dZ;
u(1)=[];y(1)=[];
end

