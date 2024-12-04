clear all;

kk = 200;
u(1:kk)=1;
y(1:7)=0;
z(1:kk)=0;
for k=8:kk
    y(k)=symulacja_obiektu15y_p2(u(k-6), u(k-7), z(k-3), z(k-4), y(k-1), y(k-2));
end

figure;
plot(y); title('y');
figure;
stairs(u);