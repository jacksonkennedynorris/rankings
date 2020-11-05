% copy of main.m

close all
sport = 'Football';firstYear = true;OldName = [];inOofS = [];outOofS = [];eloFirstYear = true;
for i = [2018]
    year = num2str(i)
    %% Get all matrices
    [Game,PD,Loc,~,~,~,OofS,Forfeits] = loadingMatrices(year,sport);% Input Year, sport, and week length if applicable

    [Name,Region] = getNameAndRegion(year,sport);

    %Elo = 1500*ones(length(Name),1);
    [Game,Name,Region,OofS] = removeTeamsNoGames(Game,Name,Region,OofS);  
    
    [NameRecord] = calculateRecord(Name,OofS,Game,PD,Region);
    
    [Game,PD,Loc] = removeForfeits(Game,PD,Loc,Forfeits);

    [inGame,outGame,inPD,outPD,inLoc,outLoc] = regionGames(Game,Name,Region,PD,Loc);

    %[initElo] = initialElo(Game,firstYear,Elo,Name,OldName,year);

     % artificially inserting game
%     Game = [Game; zeros(1,size(Game,2))];
%     Game(end,131)=1;
%     Game(end,186)=-1;
%     PD=[PD;70];
%     Loc=[Loc;1];
    
    
    %% Ratings!!
    Massey = masseyRatingW(Game,PD,Loc);
    Colley = colleyRatingW(Game,PD,Loc);
    %Elo = eloRating(Game,PD,Loc,initElo);
    %% Generate and print tables
    Elo = 1500*ones(length(Name),1);
    [A1,A2,A3,A4,A5,A6,total] = sortByRegion(NameRecord,Region,Massey,Colley,Elo,year);

    A6
    %writetable(A6,'SixATable.csv.gsheet');
    %% Find in region ratings
%     inName = Name;inRegion = Region;
%     [inGame,inName,inRegion] = removeTeamsNoRegionGames(inGame,inName,inRegion);
%     [inNameRecord] = calculateRecord(inName,inOofS,inGame,inPD,inRegion);
%     [ininitElo] = initialElo(inGame,eloFirstYear,inElo,inName,OldName,year);
%     inMassey = masseyRating(inGame,inPD,inLoc);inColley = colleyRating(inGame,inPD,inLoc,HFA);inElo = eloRating(inGame,inPD,inLoc,ininitElo); 
% %% Create final tables for in region
%     [A1r,A2r,A3r,A4r,A5r,A6r,totalr] = sortByRegion(inNameRecord,inRegion,inMassey,inColley,inElo,year);
% %% Juxtapose one region with another 
%     outName = Name; outRegion = Region;
%     [outGame,outName,outRegion,inElo] = removeTeamsNoRegionGames(outGame,outName,outRegion,inElo);
%     [outNameRecord] = calculateRecord(outName,outOofS,outGame,outPD,outRegion);
%     [outinitElo] = initialElo(outGame,eloFirstYear,outElo,outName,OldName,year);
%     outMassey = masseyRating(outGame,outPD,outLoc);outColley = colleyRating(outGame,outPD,outLoc,HFA);outElo = eloRating(outGame,outPD,outLoc,outinitElo);
%     [A1o,A2o,A3o,A4o,A5o,A6o,totalo] = sortByRegion(outNameRecord,outRegion,outMassey,outColley,outElo,year);
%     [finalTableOut,myCell] = allRegionsJuxtaposed(outGame,outPD,outLoc,inElo,outRegion,outName);
%     myCell
    
    %% Change values
    OldName = Name;
    firstYear = false;
end