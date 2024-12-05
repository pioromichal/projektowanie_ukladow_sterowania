function [ke_r, ku_r] = DMC_rozmyty_offline(modele, ...
    N,Nu,lambdy,D)
    liczba_modeli = length(modele);
    ke_r = [];
    ku_r = [];
    
    for i = 1:liczba_modeli
        % Model odpowiedzi skokowej
        ys = modele{i};
        % DMC obliczenia offline
        [ke_r1, ku_r1] = DMC_offline(ys,N,Nu,lambdy(i),D); 
        ke_r = [ke_r, ke_r1];
        ku_r = [ku_r; ku_r1];
    end
end