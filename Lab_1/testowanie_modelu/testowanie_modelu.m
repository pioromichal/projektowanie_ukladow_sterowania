clear; close all;

Ko = 0.010881;
To = 9;
T1 = 83.3474;
T2 = 2.4876;
[a1, a0, b1, b0] = parametry_rownania_roznicowego(Ko,To,T1,T2);


kk=600; % koniec symulacji
u(1:kk)=45; y(1:11)=32.68; 

% główna pętla symulacyjna
for k=12:kk 
    % symulacja obiektu
    y(k) = -a1*y(k-1) -a0*y(k-2) + b1*u(k-10) + b0*u(k-11);
end

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;

figure; stairs(y); hold on; %stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;