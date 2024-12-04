kk = 200;
u(1:7)=0;
y(1:7)=0;
z(1:kk)=0;
yzad(1:kk)=1;
e(1:kk)=0;
K=3.168;
for k=8:kk
    y(k)=symulacja_obiektu15y_p2(u(k-6), u(k-7), z(k-3), z(k-4), y(k-1), y(k-2));
    e(k)=yzad(k)-y(k);
    u(k)=K*e(k);
end

figure;
stairs(y); hold on; stairs(yzad); title('y');
figure;
stairs(u);

%%
% Kkryt = 3.168
% Tkryt = 10