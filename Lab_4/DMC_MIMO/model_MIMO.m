function [y,u] = model_MIMO(T1,T2,K,Td,kk,Upp,Ypp)
    kp=max(Td(:))+3;
    alfa1 = exp(-1./T1);
    alfa2 = exp(-1./T2);
    
    a1 = - alfa1 - alfa2;
    a2 = alfa1.*alfa2;
    
    b1 = (K./(T1-T2)).*(T1.*(1-alfa1)-T2.*(1-alfa2));
    b2 = (K./(T1-T2)).*(alfa1.*T2.*(1-alfa2)-alfa2.*T1.*(1-alfa1));
    
    kk = kk+kp;
    
    u(1,1:kp)=Upp(1); u(1,kp:kk)=Upp(1)+15;
    u(2,1:kp)=Upp(2); u(2,kp:kk)=Upp(2);
    y(1,1:kp)=Ypp(1); y(1,kp:kk)=0;
    y(2,1:kp)=Ypp(2); y(2,kp:kk)=0;
    
    for k=3+max(Td(:)):kk
        for i=1:2
            y(i,k) = b1(i,:)*[u(1,k-Td(i,1)-1)-Upp(1);u(2,k-Td(i,2)-1)-Upp(2)] ... 
                + b2(i,:)*[u(1,k-Td(i,1)-2)-Upp(1);u(2,k-Td(i,2)-2)-Upp(2)]...
                - sum(a1(i,:).*(y(i,k-1)-Ypp(i)) + a2(i,:).*(y(i,k-2)-Ypp(i)))+Ypp(i);
        end
    end
    
    y=y(:,kp:kk);
    u=u(:,kp:kk);
end


