function E = funkcja_kosztu(parametry,kk,ymierz)
T1 = parametry(1);
T2 = parametry(2);
K = parametry(3);
Td = parametry(4);

y = model(T1,T2,K,Td,kk);

E = (ymierz - y)' * (ymierz - y);
end