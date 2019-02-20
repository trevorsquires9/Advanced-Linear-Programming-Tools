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
%   x - optimal solutions
%   output - structure of optional output variables
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [solu,output] = simplex(A,c,basicVar, solu,param)

[~,n] = size(A);

entVarSelect = defaultField(param,'entVarSelect',@dantzigPriceEnt);
exitVarSelect = defaultField(param,'exitVarSelect',@dantzigPriceExit);
maxIt = defaultField(param,'maxIt',1000);


Basis = A(:,basicVar);
Binv = inv(Basis);

nonBasicVar = setxor(1:n,basicVar);
redCosts = zeros(1,length(nonBasicVar));

for it = 1:maxIt
    %% Compute reduced costs
    for i=1:length(nonBasicVar)
        redCosts(i) = c(nonBasicVar(i)) - c(basicVar)*Binv*A(:,nonBasicVar(i));
    end
    
    if min(redCosts) >= 0
        output.exitFlag = 0;
        break;
    end
    
    %% Determine Entering Variable
    entVar = entVarSelect(redCosts, nonBasicVar);
    entDirection = zeros(n,1);
    entDirection(basicVar)= Binv*A(:,nonBasicVar(entVar));
    
    %% Determine Exiting Variable
    if max(entDirection) <= 0
        output.exitFlag = 1;
        output.direction = entDirection;
        break;
    else
        exitVar = exitVarSelect(entDirection,basicVar,solu);
    end
    entDirection(nonBasicVar(entVar)) = -1;
    entDistance = solu(basicVar(exitVar))/entDirection(basicVar(exitVar));
    
    %% Setup for next iteration
    E = eye(length(basicVar));
    E(:,exitVar) = entDirection(basicVar);
    Binv = inv(E)*Binv;
   
    solu = solu - entDistance*entDirection;
    tmp = nonBasicVar(entVar);
    nonBasicVar(entVar) = basicVar(exitVar);
    basicVar(exitVar) = tmp;
    
    
end

if it == maxIt
    output.exitFlag = 2;
end
output.it = it;
output.Binv = Binv;




end