clear; close all;
D= 125;
N = D;
Nu = D;

S = odp_jedn(D+N);
lambda=[1 1]; psi=[1 1];

[Ke,Ku]=DMC_MIMO_offline(S,D,N,Nu,lambda,psi);

%%

% % disp(Ke)
% fprintf('DMC.D_ := %d;\n', D-1);
% for row=1:2
%     for col=1:2
%         fprintf('DMC.Ke[%d,%d] := %.4f;\n', row-1, col-1, Ke(row, col));
%     end
% end
% 
% for i = 1:(D-1)
%     for row=1:2
%         for col=1:2
%             fprintf('DMC.Ku[%d,%d,%d] := %.4f;\n',i-1, row-1, col-1, Ku(row,col+(i-1)*2));
%         end
%     end
% end

%%
% Definiowanie pliku wyjściowego
fileID = fopen('output.txt', 'w');

fprintf(fileID,'DMC.D_ := %d;\n', D);
% Wypisywanie macierzy Ke do pliku
for row = 1:2
    for col = 1:2
        fprintf(fileID, 'DMC.Ke[%d,%d] := %.4f;\n', ...
            row-1, col-1, Ke(row, col));
    end
end

% Wypisywanie macierzy Ku do pliku
for i = 1:(D-1)
    for row = 1:2
        for col = 1:2
            fprintf(fileID, 'DMC.Ku[%d,%d,%d] := %.4f;\n', ...
                i-1, row-1, col-1, Ku(row, col+(i-1)*2));
        end
    end
end

% Zamknięcie pliku
fclose(fileID);

fprintf('Dane zostały zapisane do pliku "output.txt".\n');