function [y,u] = p3_odpowiedz_skokowa(kk)
%P3_ODPOWIEDZ_SKOKOW Summary of this function goes here
%   Detailed explanation goes here

Ypp=4; Upp=0.5; dU=0.2;

% kk=150; % koniec symulacji
u(1:kk)=Upp+dU; y(1:11)=4;

% główna pętla symulacyjna
for k=12:kk
    % symulacja obiektu
    y(k) = symulacja_obiektu1y_p1(u(k-10), u(k-11), y(k-1), y(k-2));
end

%normalizacja odpowiedzi skokowej
u=(u-Upp)/dU;
y=(y-Ypp)/dU;
u(1)=[];y(1)=[];
end

