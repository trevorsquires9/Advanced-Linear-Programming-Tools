clear
clc
close all;

%% Test Script for simplex.m

%% Test 1
A = [2 1 1 0; 1 1 0 1];
b = [3;2];
c = [-6 -4 0 0];

CanonLPSolve(A,b,c,1,'verbose'); %for debugging purposes
param.maxIt = 5;
[solu,output] = simplex(A,c,[3,4],[0;0;b],param);


%% Test 2 (Homework problem 1)
A = [-2 -9 1 9 1 0;1/3 1 -1/3 -2 0 1];
b = [0;0];
c = [-2 -3 1 12 0 0];
tables = CanonLPSolve(A,b,c,0); %for debugging purposes
clc
for i = 1:length(tables)
    tableToLatex(tables{i})
end


%% Test 3 (Homework problem 2)
clear param
c = [-60 -30 -20 0 0 0 0];
b = [48 20 8 5]';
iniSolu = [0;0;0;b];
A = [8 6 1 1 0 0 0; 4 2 1.5 0 1 0 0; 2 1.5 0.5 0 0 1 0;0 1 0 0 0 0 1];
param.maxIt = 50;
[solu,output] = simplex(A,c,4:7,iniSolu, param);


%% Test 4 (Homework problem 3)
clear param
c = [-0.005 -1 0 0];
A = [6 1 1 0;-3 1 0 1];
b = [4 4];
CanonLPSolve(A,b,c,0)

