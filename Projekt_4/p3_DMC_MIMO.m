function [Y,U,E] = p3_DMC_MIMO(kk,Y_zad,D,N,Nu,lambda,psi)
    S=p2_odpowiedzi_skokowe(D+N+Nu);
    [Ke,Ku]=DMC_MIMO_offline(S,D,N,Nu,lambda,psi);
    
    U = zeros(4, kk+4);
    Y = zeros(3, kk+4);
    Y_zad = [repmat(Y_zad(:,1), 1, 4),Y_zad];
    dUp=zeros(4,D-1);
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
        dU=DMC_MIMO_dU(Y(:,k),Y_zad(:,k),Ke,Ku,dUp);
        U(:,k)=U(:,k-1)+dU;
        dUp(:,2:end)=dUp(:,1:end-1);
        dUp(:,1)=dU;
        % Obliczanie błędu kwadratowego
        e = Y_zad(:,k) - Y(:,k);
        E = E + e' * e;
    end
    U = U(:, 5:end);
    Y = Y(:, 5:end);
end

