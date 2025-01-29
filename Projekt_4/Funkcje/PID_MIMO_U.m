function [U,E]=PID_MIMO_U(k,Y,Y_zad,U,E,R0,R1,R2,U_nums)
    E(:,k)=Y_zad-Y;
    
    U(:,k)=U(:,k-1);
    for i=1:3
        U_n=U_nums(i);
        U(U_n,k)=R2(i)*E(i,k-2);
        U(U_n,k)=U(U_n,k)+R1(i)*E(i,k-1);
        U(U_n,k)=U(U_n,k)+R0(i)*E(i,k);
        U(U_n,k)=U(U_n,k)+U(U_n,k-1);
    end
end