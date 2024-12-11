function sp = p2_odpowiedzi_skokowe(kk)

kk = kk+5;

U = zeros(4, kk); % macierz dla u1, u2, u3, u4 
y1(1:4)=0; y2(1:4)=0; y3(1:4)=0;
sp = zeros(3, 4, kk);

for i=1:4 % dla kazdego u oddzielnie
    U(i, 5:kk) = 1; % ustawienie skoku na i-tym wejściu

    % główna pętla symulacyjna
    for k=5:kk
        % symulacja obiektu
        [y1(k), y2(k), y3(k)] = symulacja_obiektu15y_p4( ...
            U(1, k-1), U(1, k-2), U(1, k-3), U(1, k-4), ...
            U(2, k-1), U(2, k-2), U(2, k-3), U(2, k-4), ...
            U(3, k-1), U(3, k-2), U(3, k-3), U(3, k-4), ...
            U(4, k-1), U(4, k-2), U(4, k-3), U(4, k-4), ...
            y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
            y2(k-1), y2(k-2), y2(k-3), y2(k-4), ...
            y3(k-1), y3(k-2), y3(k-3), y3(k-4));
    end
    sp(1, i, :) = y1;
    sp(2, i, :) = y2;
    sp(3, i, :) = y3;

    y1(1:kk)=0;y2(1:kk)=0;y3(1:kk)=0;
    U(i, 5:kk) = 0;
end

% %normalizacja odpowiedzi skokowej
% u=(u-Upp)/dU;
% y=(y-Ypp)/dU;
% u(1:8)=[];y(1:8)=[];
end