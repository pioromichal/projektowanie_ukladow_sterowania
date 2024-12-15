function [dU]=DMC_MIMO_full_y_dU(y,y_zad,K,Mp,dUp)
    ny=size(y,1);
    nu=size(dUp,1);
    N=size(K,2)/ny;
    dU=K*(repmat(y_zad, N, 1)-repmat(y, N, 1)-Mp*dUp(:));
    dU=dU(1:nu);
end