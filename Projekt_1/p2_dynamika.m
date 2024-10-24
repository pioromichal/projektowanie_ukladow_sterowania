clear; close all;

y(1:11)=2; e(1:11)=0; 
kk=750; % koniec symulacji

u(1:50)=1.2; u(51:200)=1.3; u(201:350)=1.4; u(351:500)=1.5; u(501:750)=0.9;
% główna pętla symulacyjna
for k=12:kk 
    % symulacja obiektu
    y(k) = symulacja_obiektu15y_p1(u(k-10), u(k-11), y(k-1), y(k-2));
end

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;
% close;


figure; stairs(y); hold on;
xlabel('k'); ylabel('y'); grid on; grid minor;
% close;