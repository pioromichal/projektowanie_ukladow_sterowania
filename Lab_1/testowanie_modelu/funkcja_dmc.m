function [y,u]=funkcja_dmc(kk, yzad, N, Nu, D, lambda)

umin = 0; umax=100;

% [r2, r1, r0] = p4_pid_strojenie(Kk,Tk,0.5);

K = 0.38024;
Td = 6;
T1 = 82.0474;
T2 = 3.3333;
[a1, a0, b1, b0] = parametry_rownania_roznicowego(K,Td,T1,T2);
Ypp = 32.68; Upp = 25;

% warunki początkowe
kks=700;
us(1:kks)=1;
ys = p3_model(T1,T2,K,Td,kks,us);

% Konstrukcja macierzy M
M = zeros(N,Nu);
for column=1:Nu
    M(column:N,column) = ys(1:N-column+1);
end

% Konstrukcja macierzy Mp
Mp = zeros(N,D-1);
for j = 1:D-1
    for i = 1:N
        c = min([i+j,D]);
        Mp(i,j) = ys(c) - ys(j);
    end
end

% Obliczenie macierzy sterującej K
K = (M.'*M + lambda*eye(Nu,Nu))\M.';
K1 = K(1,:);
ke = sum(K1);
ku = K1*Mp;

% Warunki początkowe
u(1:kk)=Upp; y(1:kk)=Ypp; e(1:kk)=0;
delta_u_p(1:D-1)=0;

for k=12:kk 
    % symulacja obiektu
    y(k) = Ypp -a1*(y(k-1)-Ypp)-a0*(y(k-2)-Ypp) + 1*(b1*(u(k-10)-Upp) + b0*(u(k-11)-Upp));

    % uchyb regulacji
    e(k)=yzad(k)-y(k);

    % Obliczenie przyrostu sygnału sterującego DMC
    delta_u = ke * e(k) - ku * delta_u_p';
    
    u(k)=u(k-1)+delta_u;

    if u(k) < umin
        u(k) = umin;
    elseif u(k) > umax
        u(k) = umax;
    end
end

end