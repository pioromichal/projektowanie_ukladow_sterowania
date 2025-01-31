D = 125;

load('D:\Radek\STUDIA\2024Z\PUST\LAB\Lab_4\Pomiary\SKOK_U1_+15.mat')

ys11 = y1(42+1:end);
ys21 = y2(42+1:end);

load('D:\Radek\STUDIA\2024Z\PUST\LAB\Lab_4\Pomiary\SKOK_U2_+15.mat')

ys12 = y1(45+1:end);
ys12(1:10)=ys12(11);
ys22 = y2(45+1:end);

figure; hold on; grid on; grid minor; xlabel('k'); ylabel('y');
plot(ys11(1:4:end)); plot(ys21(1:4:end)); plot(ys12(1:4:end));plot(ys22(1:4:end)); legend('G1 \rightarrow T1','G1 \rightarrow T3','G2 \rightarrow T1','G2 \rightarrow T3',Location='best');
exportgraphics(gcf, 'Wykresy/odp_jedn_real.pdf', 'ContentType', 'vector');

[~,ys11,ys21,ys12,ys22] = odp_jedn(D);

figure; hold on; grid on; grid minor; xlabel('k'); ylabel('y');
plot(ys11); plot(ys21); plot(ys12);plot(ys22); legend('G1 \rightarrow T1','G1 \rightarrow T3','G2 \rightarrow T1','G2 \rightarrow T3',Location='best');
exportgraphics(gcf, 'Wykresy/odp_jedn_approx.pdf', 'ContentType', 'vector');

