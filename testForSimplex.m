clear
clc
close all;

%% Test Script for simplex.m

%% Test 1
A = [2 1 1 0; 1 1 0 1];
b = [3;2];
c = [-6 -4 0 0];

%CanonLPSolve(A,b,c,1,'verbose'); %for debugging purposes
param.maxIt = 5;
[solu,output] = simplex(A,c,[3,4],[0;0;b],param);


%% Test 2 (Homework problem 1)
A = [-2 -9 1 9 1 0;1/3 1 -1/3 -2 0 1];
b = [0;0];
c = [-2 -3 1 12 0 0];
%CanonLPSolve(A,b,c,0); %for debugging purposes
param.maxIt = 10;
param.exitVarSelect = @kuhnExit;
[solu,output] = simplex(A,c,[5 6], [0;0;0;0;b],param);