function [y, u, E] = p5_pid_rozmyty(ilosc_modeli)
    addpath("Funkcje\");
    addpath("funkcje_przynaleznosci\");

    Tp=0.5;
    kk = 600;

    yzad(1:100)=-0.2;yzad(101:200)=2;yzad(201:300)=6;yzad(301:400)=11;
    yzad(401:500)=0; yzad(501:600)=6;
    
    if ilosc_modeli == 1
        centra_rozmycia = 1.00;
        z_switch = 1.00;
        K_values = 0.09001;
        Ti_values = 4.29786;
        Td_values = 0.11634;
    
        % K_dol = 0.01; K_gor = 3;
        % Ti_dol = 0.01; Ti_gor= 10;
        % Td_dol = 0; Td_gor= 1;
        % parametry_pocz = [0.05*I, 7.0*I, 2.0*I];
        % ogr_dol = [K_dol*I, Ti_dol*I, Td_dol*I];
        % ogr_gor = [K_gor*I, Ti_gor*I, Td_gor*I];
    
    elseif ilosc_modeli == 2
        centra_rozmycia = [0.00 4.00];
        z_switch = 1.00;
        K_values = [0.19060 0.06232];
        Ti_values = [4.02327 4.31750];
        Td_values = [0.55439 0.05790];
    
    elseif ilosc_modeli == 3
        centra_rozmycia = [0, 3, 6]; % Centra rozmycia dla każdego modelu
        z_switch = 1;
        % wyliczane z błędu kwadratowego
        K_values = [0.17832 0.10239 0.05427];
        Ti_values = [2.69015 7.84737 3.52440];
        Td_values = [0.94919 0.26134 0.07093];
    
        % wyliczane z błędu absolutnego
        % K_values = [0.23837 0.06119 0.05101];
        % Ti_values = [2.84432 3.84489 3.87651];
        % Td_values = [0.81036 0.76819 0.11292];
    
        % K_dol = 0.01; K_gor = 3;
        % Ti_dol = 0.01; Ti_gor= 10;
        % Td_dol = 0; Td_gor= 1;
        % parametry_pocz = [0.5*I, 1.0*I, 0.0*I];
        % ogr_dol = [K_dol*I, Ti_dol*I, Td_dol*I];
        % ogr_gor = [K_gor*I, Ti_gor*I, Td_gor*I];
    elseif ilosc_modeli == 4
        % ga
        centra_rozmycia = [-0.30  1.00  4.00  8.00];
        z_switch = 1.00;
        K_values = [0.24600 0.08191 0.06264 0.06181];
        Ti_values = [6.20168 4.33436 6.84850 3.57889];
        Td_values = [0.56929 0.48366 0.05358 0.05684];
    
    elseif ilosc_modeli == 5
        centra_rozmycia = [0.00  2.00  4.00  8.00 10.00];
        z_switch = 1.00;
        K_values = [0.17329 0.12520 0.04616 0.11658 0.10576];
        Ti_values = [2.53968 5.64913 7.06806 1.26287 4.94235];
        Td_values = [0.99052 0.35427 0.01298 0.09492 0.99590];
    
%         centra_rozmycia = [0.00  1.50  4.00  7.00 10.00];
%         z_switch = 1.00;
%         K_values = [0.25124 0.04768 0.21287 0.07260 0.10373];
%         Ti_values = [6.42941 2.60320 3.81477 1.30985 4.21462];
%         Td_values = [0.53562 0.99998 0.99846 0.21803 0.90616];
    
    end
    
    
    % Walidacja ilości modeli i parametrów
    if length(K_values) ~= ilosc_modeli || length(Ti_values) ~= ilosc_modeli || length(Td_values) ~= ilosc_modeli
        error('Liczba modeli i liczba parametrów nie są zgodne!');
    end
    
    % Tworzenie modeli w pętli
    parametry_pid = cell(1, ilosc_modeli);
    for i = 1:ilosc_modeli
        parametry_pid{i} = p5_pid_offline_rozmyty(K_values(i), Ti_values(i), Td_values(i), Tp);
    end
    
    [y, u] = p5_funkcja_pid_rozmyty(kk, yzad, parametry_pid, centra_rozmycia, z_switch);
    
    E = (yzad(1:kk)-y)*(yzad(1:kk)-y)';
end

