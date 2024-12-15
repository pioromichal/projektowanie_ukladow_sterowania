function [dU]=DMC_MIMO_dU(y,y_zad,Ke,Ku,dUp)
    dU=Ke*(y_zad-y);
    nu=size(Ke,1);
    for i=1:size(Ku,2)/nu
        dU=dU-Ku(:,1+(i-1)*nu:i*nu)*dUp(:,i);
    end
end