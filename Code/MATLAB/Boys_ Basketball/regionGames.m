function [inGame,outGame,inPD,outPD,inLoc,outLoc,inName,outName,inRegion,outRegion] = regionGames(Game,Name,Region,PD,Loc)
inGame = [];outGame = [];inPD = [];outPD = [];inLoc = [];outLoc = [];
for elem = 1:length(Game(:,1))
    K = find(Game(elem,:));
    if K 
        i = K(1);
        j = K(2);
        regionFirst = Region(i);
        regionSecond = Region(j);
        if regionFirst == regionSecond
            inGame = [inGame;Game(elem,:)];
            inPD = [inPD;PD(elem)];
            inLoc = [inLoc;Loc(elem)];
        else
            outGame = [outGame;Game(elem,:)];
            outPD = [outPD;PD(elem)];
            outLoc = [outLoc;Loc(elem)];
        end
    end
end
inName = Name;inRegion = Region;outName = Name; outRegion = Region;