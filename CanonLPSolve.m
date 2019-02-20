function [ Tables, optSolu, optVal ] = CanonLPSolve( A, b, c, userInput, ~ )
% This is a LP solver with steps.  It requires an input tableau in
% canonical form to begin and outputs the optimal tableau along with the
% necessary steps to get there.

%A and b are standard variables in the form of Ax = b
%c is the initial reduced cost vector
% userInput should be a boolean variable determining whether the user wants
    % to determine the pivots, or let a default rule take over
% The last variable determines whether or not the user wants additional
    % output information 
[m,n] = size(b);
if m<n
    b = b';
end

[m,n] = size(A);




if min(b) < 0
    error('The problem is not dual feasible\n');
elseif rank(A) ~= m
    error('The matrix does not have linearly independent rows\n');
elseif length(b) ~= m
    error('The dimension of something are incorrect\n');
elseif length(c) ~= n
    error('You must input a c value for all variables\n');
end

basicVariables = n-m+1:n;

table = [c;A];
table = [table [0;b]];

Tables = {table};

if nargin>4
    fprintf('The intial table looks like this (where the right hand side is the b vector)\n');
    disp(table)
    fprintf('With basic variable indices')
    disp(basicVariables);
    fprintf('----------------------------------------------------------------------------\n')
end

while min(table(1,:)) < 0
    if nargin>4
        fprintf('The table is not optimal, so we perform a pivot\n');
    end
    
    if userInput == 1
        enterBasis = greedyEnterRule(table);
        exitBasisVector = table(2:end,enterBasis);
        bVector = table(2:end,end);
        exitBasis = greedyExitRule(exitBasisVector,bVector);
    else
        fprintf('Your table currently looks like this\n')
        disp(table)
        enterBasis = menu('Please input the column number indicating the variable entering the basis\n',num2cell(1:n+1));
        if max(table(2:end,enterBasis)) < 0
            fprintf('No available pivots. LP is unbounded!\n')
            return;
        end
        if enterBasis == n+1
            fprintf('User has opted to quit.\n')
            return;
        end
        exitBasis = menu('Please input the row number indicating the variable exiting the basis\n',num2cell(1:m+1))-1;

            
    end

    
    
    if nargin>4
        fprintf('\nWe now perform a pivot removing x%d from the basis and adding x%d into the basis\n', basicVariables(exitBasis),enterBasis);
    end
    basicVariables(exitBasis) = enterBasis;
    
    for i = 1:m+1
        if i~= exitBasis+1
            multiplier = (-1)*table(i,enterBasis)/table(exitBasis+1,enterBasis);
            table(i,:) = table(i,:)+multiplier*table(exitBasis+1,:);
        else
            table(i,:) = table(i,:)/table(exitBasis+1,enterBasis);
        end
    end
    fprintf('So after the pivot, your new table looks like this\n');
    disp(table)
    Tables{end+1} = table;
    fprintf('With basic variable indices')
    disp(basicVariables);
    fprintf('----------------------------------------------------------------------------\n')
end


optSolu = zeros(1,n);
optSolu(basicVariables) = table(2:end,end);
optVal = table(1,end);
fprintf('The table is now optimal\n')

fprintf('\nThe optimal solution is ')
disp(optSolu)
fprintf('And optimal value of %d\n',optVal)

end
