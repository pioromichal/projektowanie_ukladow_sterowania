function [Y,U,E] = p3_PID_MIMO(kk,Tp,Y_zad,K,Ti,Td,U_nums)
    [R2,R1,R0]=PID_MIMO_offline(K,Ti,Td,Tp);
    ny=size(Y_zad,1);
    U = zeros(4, kk+4);
    Y = zeros(3, kk+4);
    Y_zad = [repmat(Y_zad(:,1), 1, 4),Y_zad];
    E_PID=zeros(ny,kk);
    E=0;
    for k=5:kk+4
        [Y(1,k),Y(2,k),Y(3,k)] = symulacja_obiektu15y_p4( ...
                U(1, k-1), U(1, k-2), U(1, k-3), U(1, k-4), ...
                U(2, k-1), U(2, k-2), U(2, k-3), U(2, k-4), ...
                U(3, k-1), U(3, k-2), U(3, k-3), U(3, k-4), ...
                U(4, k-1), U(4, k-2), U(4, k-3), U(4, k-4), ...
                Y(1, k-1), Y(1, k-2), Y(1, k-3), Y(1, k-4), ...
                Y(2, k-1), Y(2, k-2), Y(2, k-3), Y(2, k-4), ...
                Y(3, k-1), Y(3, k-2), Y(3, k-3), Y(3, k-4));
    
        [U,E_PID]=PID_MIMO_U(k,Y(:,k),Y_zad(:,k),U,E_PID,R0,R1,R2,U_nums);

        % Obliczanie błędu kwadratowego
        e = Y_zad(:,k) - Y(:,k);
        E = E + e' * e;
    end
    U = U(:, 5:end);
    Y = Y(:, 5:end);
end

