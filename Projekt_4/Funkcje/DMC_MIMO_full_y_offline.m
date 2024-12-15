function [K, Mp] = DMC_MIMO_full_y_offline(S, D, N, Nu, lambda, psi)
    M=DMC_MIMO_M(S,N,Nu);
    Mp=DMC_MIMO_Mp(S,D,N);

    Psi = kron(eye(N), diag(psi));
    Lambda = kron(eye(Nu), diag(lambda));
    
    K=(M'*Psi*M+Lambda)\M'*Psi;
end