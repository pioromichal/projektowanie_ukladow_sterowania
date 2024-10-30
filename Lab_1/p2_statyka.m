a = odczyt_danych_z_txt("pomiary/skok_1_30.txt");
b = odczyt_danych_z_txt("pomiary/skok_2_40.txt");
c = odczyt_danych_z_txt("pomiary/skok_3_35.txt");
d = odczyt_danych_z_txt("pomiary/skok_4_45.txt");

figure
stairs(a); hold on;
stairs(b);
stairs(c);
stairs(d);
xlim([0,500]);

%ch-ka statyczna obiektu
figure
plot([25,30,35,40,45],[32.68,34.56,36.5,38.1,40])