clear all;

Td = 5;
kk = 200+Td+3;
u(1:Td+2)=0;u(Td+3:kk)=1;
y(1:7)=0;
z(1:kk)=0;
for k=Td+3:kk
    y(k)=symulacja_obiektu15y_p2(u(k-6), u(k-7), z(k-3), z(k-4), y(k-1), y(k-2));
end

y(1:Td+3)=[];

figure;
plot(y); title('y');
hold on;
plot(2.007*0.63*ones(1,length(y)));
% figure;
% stairs(u);