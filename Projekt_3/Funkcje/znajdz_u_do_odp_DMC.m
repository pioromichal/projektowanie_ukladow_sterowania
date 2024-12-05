function u = znajdz_u_do_odp_DMC(y_szuk)
% Funkcja zwraca wartość u na podstawie y_zad
% us - wektor wartości sterowania
% ys - wektor odpowiadających wartości wyjścia
%
% y_szuk - żądana wartość wyjścia

kk=500; % koniec symulacji

us=-1:0.05:1;
ys=zeros(length(us),1);

for i=1:length(us)
    u(1:kk)=us(i); y(1:6)=0;
    % główna pętla symulacyjna
    for k=7:kk
        % symulacja obiektu
        y(k) = symulacja_obiektu15y_p3(u(k-5), u(k-6), y(k-1), y(k-2));
    end
    ys(i) = y(kk);
end


% Sprawdzenie zakresu
if y_szuk < min(ys) || y_szuk > max(ys)
    error('y_zad znajduje się poza zakresem charakterystyki statycznej.');
end

% Interpolacja numeryczna
u = interp1(ys, us, y_szuk, 'linear');
end