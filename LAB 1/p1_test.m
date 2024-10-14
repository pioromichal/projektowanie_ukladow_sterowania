clear; close all;
kk=200; % koniec symulacji
u(1:kk)=0.4; y(1:11)=4; 

% główna pętla symulacyjna
for k=12:kk 
    % symulacja obiektu
    y(k) = symulacja_obiektu1y_p1(u(k-10), u(k-11), y(k-1), y(k-2));
end

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;

figure; stairs(y); hold on; %stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;