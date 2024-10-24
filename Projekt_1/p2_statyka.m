clear all; close all;

kk=500; % koniec symulacji

us=0.9:0.05:1.5;
ys=zeros(length(us),1);

for i=1:length(us)
    u(1:kk)=us(i); y(1:11)=2;
    % główna pętla symulacyjna
    for k=12:kk
        % symulacja obiektu
        y(k) = symulacja_obiektu15y_p1(u(k-10), u(k-11), y(k-1), y(k-2));
    end
    ys(i) = y(kk);
end

figure; plot(us,ys)
ylabel('y'); xlabel('u'); grid on; grid minor;

% K=2