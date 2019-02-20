function [  ] = tableToLatex(table)

[row,col] = size(table);

%% Header
fprintf('\\begin{equation*}\n\t\\begin{tabular}{|c')
for i = 1:col-2
    fprintf('c')
end
fprintf('|c|}\\hline\n')

%% Table data
fprintf('\t%0.1f ',table(1,1))
for i = 2:col
    fprintf('& %0.1f ',table(1,i))
end
fprintf('\\\\ \\hline\n')

for i = 2:row
    fprintf('\t%0.1f ',table(i,1))
    for j= 2:col
        fprintf('& %0.1f ',table(i,j))
    end
fprintf('\\\\\n')
end

%% Footer
fprintf('\t\\hline')
fprintf('\n\t\\end{tabular}\n\\end{equation*}')
