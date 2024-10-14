clear all; close all;
u(1:11)=0.3; y(1:11)=4; e(1:11)=0; 
kk=500; % koniec symulacji

u(1:100)=0.3; u(101:200)=0.4; u(201:300)=0.5; u(301:400)=0.6; u(401:500)=0.7;
% główna pętla symulacyjna
for k=12:kk 
    % symulacja obiektu
    y(k) = symulacja_obiektu1y_p1(u(k-10), u(k-11), y(k-1), y(k-2));
end

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;
% close;


figure; stairs(y); hold on;
xlabel('k'); ylabel('y'); grid on; grid minor;
% close;