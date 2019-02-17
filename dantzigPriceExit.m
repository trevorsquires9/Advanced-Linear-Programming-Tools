function [exiting] = dantzigPriceExit(exitDirection,basicVar,solu)


minDist = Inf;

for i = 1:length(basicVar)
    if solu(basicVar(i)) >= 0 && exitDirection(basicVar(i)) >= 0
        tmpDist = solu(basicVar(i))/exitDirection(basicVar(i));
        if tmpDist<=minDist
            minDist = tmpDist;
            exiting = i;
        end
    end

end

