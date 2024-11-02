function [y,u] = p3_odpowiedz_skokowa(kk)
%P3_ODPOWIEDZ_SKOKOW Summary of this function goes here
%   Detailed explanation goes here
kk = kk +1;
Ypp=2; Upp=1.2; dU=0.05;

% kk=150; % koniec symulacji
u(1:kk)=Upp+dU; y(1:11)=2; y(12:kk)=0;

% główna pętla symulacyjna
for k=12:kk
    % symulacja obiektu
    y(k) = symulacja_obiektu15y_p1(u(k-10), u(k-11), y(k-1), y(k-2));
end

%normalizacja odpowiedzi skokowej
u=(u-Upp)/dU;
y=(y-Ypp)/dU;
u(1)=[];y(1)=[];
end

