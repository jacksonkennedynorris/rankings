function [final] = logisticFunction(myCell,crossRegion)
xDiff = [];
maximum = max(crossRegion);
maximum = max(maximum);
for elem = 1:length(myCell)
    if ~isempty(myCell{elem})
        if sum(size(myCell(elem))) ~= 0
            cellMatrix = myCell(elem); 
            cellMatrix = cell2mat(cellMatrix);
            ratingDiff = cellMatrix(:,2) - cellMatrix(:,1);
            outcome = cellMatrix(:,3);
            if length(ratingDiff)>=10
    %             figure(elem)
                [b,dev,stats] = glmfit(ratingDiff,outcome,'binomial','link','logit');
                XX=linspace(-300,300);
                yfit=glmval(b,XX,'logit');
                glmval(b,(-1*b(1))/b(2), 'logit'); %x value where y = .5 
                calcX = -b(1)/b(2); 
    %             plot(ratingDiff,outcome,'o',XX,yfit,'-','LineWidth',2);
    %             title(mat2str(crossRegion(elem,:)));
            else
                calcX = 0;
            end
            xDiff = [xDiff;calcX];
        end
    end
end
height = length(crossRegion);
% regionMat = zeros(height,maximum);
regionMat = [];
for elem = 1:length(crossRegion)
    if ~isempty(myCell{elem})
        regionMat = [regionMat;zeros(1,maximum)];
        temp = crossRegion(elem,:);
        temp1 = temp(1); 
        temp2 = temp(2);
        regionMat(end,temp1) = 1;
        regionMat(end,temp2) = -1;
    end
end
myLength = length(xDiff); 
for elem = myLength:-1:1
    if xDiff(elem) == 0
        xDiff(elem) = [];
        regionMat(elem,:) = [];
    end
end

len = size(regionMat,2); %Find number of teams
regionMat = [regionMat; ones(1,len)]; %Add ones to the last row in the game matrix
xDiff = [xDiff; 0]; %Add a zero to the last column in the game matrix
M = regionMat'*regionMat; %Multiply the inverse of the game time the Game (document calls this M)

%%FINAL CALCULATION%%
final=inv(M)*regionMat'*xDiff;