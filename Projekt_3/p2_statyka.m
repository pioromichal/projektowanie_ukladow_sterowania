clear all; close all;

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

% Wykres charakterystyki statycznej
plot(us, ys); % Wykres
ylabel('y'); % Etykieta osi Y
xlabel('u'); % Etykieta osi X
title('Charakterystyka statyczna'); % Tytuł wykresu
grid on; 
grid minor;

% Zmień kropki na przecinki na osiach
zamien_kropki(); 
exportgraphics(gcf, 'Wykresy/p2_charakterystyka_statystyczna.pdf', 'ContentType', 'vector');
% close;
% K=? bo nieliniowe