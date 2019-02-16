%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMPLEX.m
%
% DESCRIPTION
%   Applies the simplex method to a given primal problem. 
%
% AUTHOR
%   Trevor Squires
%
% ARGUMENTS
%   A - m x n  matrix
%   c - 1 x n cost vector
%   param - optional parameters
%
% OUTPUT
%   output - structure of output variables
%   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output] = simplex(A,c,param)