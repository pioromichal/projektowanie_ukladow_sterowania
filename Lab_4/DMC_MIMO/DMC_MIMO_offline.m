function [Ke, Ku] = DMC_MIMO_offline(S, D, N, Nu, lambda, psi)
    [ny, nu, ~] = size(S); 
    M=DMC_MIMO_M(S,N,Nu);
    Mp=DMC_MIMO_Mp(S,D,N);

    Psi = kron(eye(N), diag(psi));
    Lambda = kron(eye(Nu), diag(lambda));
    
    K=(M'*Psi*M+Lambda)\M'*Psi;
    K1=K(1:nu,:);
    Ke=0;
    for i = 1:N
        Ke = Ke + K1(:,1+(i-1)*ny:i*ny);
    end
    Ku=K1*Mp;
end