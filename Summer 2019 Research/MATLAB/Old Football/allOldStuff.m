function data4 = allOldStuff(year,sport)%[Name,Region,outOfStateRecord,inStateRecord] = allOldStuff(year,sport)

% [Game,PD,Loc,OofS,Forfeits] = loadingMatrices(year,sport);% Input Year, sport, and week length if applicable
% % [Name,Region] = getNameAndRegion(year,sport);
% [Game,Name,Region,OofS] = removeTeamsNoGames(Game,Name,Region,OofS);
% [NameRecord,Name,outOfStateRecord,inStateRecord] = calculateRecord(Name,OofS,Game,PD,Region);
% [Game,PD,Loc] = removeForfeits(Game,PD,Loc,Forfeits);

data = loadingMatrices(year,sport);
data1 = removeTeamsNoGames(data);
data2 = calculateRecord(data1);   
data3 = removeForfeits(data2);
data4 = createSmallMat(data3);

