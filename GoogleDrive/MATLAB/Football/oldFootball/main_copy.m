% copy of main.m

close all
sport = 'Football';firstYear = true;OldName = [];inOofS = [];outOofS = [];eloFirstYear = true;
for i = [2017]
    year = num2str(i)
    %% Get all matrices
    [Game,PD,Loc,~,~,~,OofS,Forfeits] = loadingMatrices(year,sport);% Input Year, sport, and week length if applicable

    [Name,Region] = getNameAndRegion(year,sport);

    %Elo = 1500*ones(length(Name),1);
    [Game,Name,Region,OofS] = removeTeamsNoGames(Game,Name,Region,OofS);  
    
    [NameRecord] = calculateRecord(Name,OofS,Game,PD,Region);
    
    [Game,PD,Loc] = removeForfeits(Game,PD,Loc,Forfeits);

    [inGame,outGame,inPD,outPD,inLoc,outLoc] = regionGames(Game,Name,Region,PD,Loc);

    [initElo] = initialElo(Game,firstYear,Elo,Name,OldName,year);

     % artificially inserting game
    Game = [Game; zeros(1,size(Game,2))];
    Game(end,131)=1;
    Game(end,186)=-1;
    PD=[PD;70];
    Loc=[Loc;1];
    
    %% Ratings!!
    Massey = masseyRatingW(Game,PD,Loc);
    Colley = colleyRatingW(Game,PD,Loc);
    %Elo = eloRating(Game,PD,Loc,initElo);
    %% Generate and print tables
    Elo = 1500*ones(length(Name),1);
    [A1,A2,A3,A4,A5,A6,total] = sortByRegion(NameRecord,Region,Massey,Colley,Elo,year);

    A6
    %writetable(A6,'SixATable.csv.gsheet');
    
    %% Change values
    OldName = Name;
    firstYear = false;
end