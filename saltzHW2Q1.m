%% Question 1
clear
clc

A = [-2 -9 1 9 1 0;1/3 1 -1/3 -2 0 1];
b = [0;0];
c = [-2 -3 1 12 0 0];
tables = CanonLPSolve(A,b,c,0);
clc
for i = 1:length(tables)
    tableToLatex(tables{i})
end

%% Question 2
clear param
c = [-60 -30 -20 0 0 0 0];
b = [48 20 8 5]';
iniSolu = [0;0;0;b];
A = [8 6 1 1 0 0 0; 4 2 1.5 0 1 0 0; 2 1.5 0.5 0 0 1 0;0 1 0 0 0 0 1];
param.maxIt = 50;
[solu,output] = simplex(A,c,4:7,iniSolu, param);