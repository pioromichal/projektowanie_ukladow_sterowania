clear; close all;

Ko = 0.38024;
To = 6;
T1 = 82.0474;
T2 = 3.3333;
[a1, a0, b1, b0] = parametry_rownania_roznicowego(Ko,To,T1,T2);

Ypp = 32.68; Upp = 25;
kk=600; % koniec symulacji
u(1:kk)=45; y(1:11)=32.68;

% główna pętla symulacyjna
for k=12:kk 
    % symulacja obiektu
    y(k) = Ypp -a1*(y(k-1)-Ypp)-a0*(y(k-2)-Ypp) + 1*(b1*(u(k-10)-Upp) + b0*(u(k-11)-Upp));
end

% wyniki symulacji
figure; stairs(u);
ylabel('u'); xlabel('k'); grid on; grid minor;

figure; stairs(y); hold on; %stairs(yzad,':');
xlabel('k'); ylabel('y'); grid on; grid minor;