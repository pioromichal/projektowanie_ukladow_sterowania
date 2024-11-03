function [y,u] = p3_odpowiedz_skokowa_u(kk)
kk = kk +1;
Ypp=0; Upp=0; dU=1;

u(1:kk)=Upp+dU; y(1:kk)=0; z(1:kk)=0;

% główna pętla symulacyjna
for k=8:kk
    % symulacja obiektu
    y(k) = symulacja_obiektu15y_p2(u(k-6), u(k-7), z(k-3), z(k-4), y(k-1), y(k-2));
end

%normalizacja odpowiedzi skokowej
u=(u-Upp)/dU;
y=(y-Ypp)/dU;
u(1)=[];y(1)=[];
end

