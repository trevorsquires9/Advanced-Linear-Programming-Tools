function [entering] = kuhnExit(exitDirection,basicVar,~)

for i = 1:length(basicVar)
    if exitDirection(basicVar(i)) > 0
        entering = i;
        break;
    end

end
