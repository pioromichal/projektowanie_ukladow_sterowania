load('D:\Radek\STUDIA\2024Z\PUST\LAB\Lab_4\Pomiary\SKOK_U1_+15.mat')

ys11 = y1(42+1:end);
ys21 = y2(42+1:end);

load('D:\Radek\STUDIA\2024Z\PUST\LAB\Lab_4\Pomiary\SKOK_U2_+15.mat')

ys12 = y1(45+1:end);
ys12(1:10)=ys12(11);
ys22 = y2(45+1:end);

figure; hold on;
plot(ys11); plot(ys21); plot(ys12);plot(ys22);

[~,ys11,ys21,ys12,ys22] = odp_jedn(D);

figure; hold on;
plot(ys11); plot(ys21); plot(ys12);plot(ys22);