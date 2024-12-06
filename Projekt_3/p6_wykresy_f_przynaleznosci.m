%% 2 regulatory lokalne

% PID

centra_rozmycia = [0.00 4.00];
z_switch = 1.00;
p5_funkcje_przynaleznosci(centra_rozmycia, z_switch);
exportgraphics(gcf, 'Wykresy/f_przynaleznosci/2_pid.pdf', 'ContentType', 'vector');
close;

% DMC

centra_rozmycia = [0,1];
z_switch = 1;
p5_funkcje_przynaleznosci(centra_rozmycia, z_switch);
exportgraphics(gcf, 'Wykresy/f_przynaleznosci/2_dmc.pdf', 'ContentType', 'vector');
close;

%% 3 regulatory lokalne

% PID

centra_rozmycia = [0, 3, 6]; % Centra rozmycia dla każdego modelu
z_switch = 1;
p5_funkcje_przynaleznosci(centra_rozmycia, z_switch);
exportgraphics(gcf, 'Wykresy/f_przynaleznosci/3_pid.pdf', 'ContentType', 'vector');
close;

% DMC

centra_rozmycia = [0,1,8];
z_switch = 1;
p5_funkcje_przynaleznosci(centra_rozmycia, z_switch);
exportgraphics(gcf, 'Wykresy/f_przynaleznosci/3_dmc.pdf', 'ContentType', 'vector');
close;

%% 4 regulatory lokalne

% PID

centra_rozmycia = [-0.30  1.00  4.00  8.00];
z_switch = 1.00;
p5_funkcje_przynaleznosci(centra_rozmycia, z_switch);
exportgraphics(gcf, 'Wykresy/f_przynaleznosci/4_pid.pdf', 'ContentType', 'vector');
close;

% DMC

centra_rozmycia = [0,2,4,8];
z_switch = 2;
p5_funkcje_przynaleznosci(centra_rozmycia, z_switch);
exportgraphics(gcf, 'Wykresy/f_przynaleznosci/4_dmc.pdf', 'ContentType', 'vector');
close;

%% 5 regulatorów lokalnych

% PID

centra_rozmycia = [0.00  2.00  4.00  8.00 10.00];
z_switch = 1.00;
p5_funkcje_przynaleznosci(centra_rozmycia, z_switch);
exportgraphics(gcf, 'Wykresy/f_przynaleznosci/5_pid.pdf', 'ContentType', 'vector');
close;

% DMC

centra_rozmycia = [0,1,2,4,6];
z_switch = 1;
p5_funkcje_przynaleznosci(centra_rozmycia, z_switch);
exportgraphics(gcf, 'Wykresy/f_przynaleznosci/5_dmc.pdf', 'ContentType', 'vector');
close;