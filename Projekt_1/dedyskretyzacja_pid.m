[r2, r1, r0] = p4_pid_dyskretyzacja_param(15,40.5,999,0.5);



K = r0/2 - r1/2 - (3*r2)/2;
 
Td = -r2/(r1 - r0 + 3*r2);
 
Ti = -(r1 - r0 + 3*r2)/(4*(r0 + r1 + r2));

disp([K Ti Td]);