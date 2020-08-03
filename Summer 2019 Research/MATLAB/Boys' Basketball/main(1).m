function main
close all
year = 2019;

game = loadingMatrices(year)
%Get names and regions of the teams
%Remove teams no games
%Calculate record
game = changeGames(game)
calculateRatings(game) 




% 
% 
% firstYear = true;OldName = [];inOofS = [];outOofS = [];eloFirstYear = true;inElo = [];Elo = [];eloAdjustments = [];print2File = true;
% 
% 
%     indexYear = year-2013;
%     numYear = year;
%     year = num2str(year);
%     %% Get all matrices
%     [Game,PD,Loc,OofS,Forfeits] = loadingMatrices(year,sport);% Input Year, sport, and week length if applicable
%     [Name,Region] = getNameAndRegion(year,sport);
%     [Game,Name,Region,OofS] = removeTeamsNoGames(Game,Name,Region,OofS);
%     [NameRecord,Name,OutState,InState] = calculateRecord(Name,OofS,Game,PD,Region);   
%     [Game,PD,Loc] = removeForfeits(Game,PD,Loc,Forfeits);
%     [initElo] = initialElo(Game,firstYear,Elo,Name,OldName,year,Region,sport);
%     %% Ratings!!
%     HFA = 2;
%     Massey = masseyRatingW(Game,PD,Loc,HFA);
%     HFA = .03;
%     Colley = colleyRatingW(Game,PD,Loc,HFA);
%     
%     [Elo] = eloRating(Game,PD,Loc,initElo);
% 
%     %% Generate and print tables
%     [A1,A2,A3,A4,A5,A6,total,IMass,IColl,IElo] = sortByRegion(NameRecord,Region,Massey,Colley,Elo,year);
%     %% Work on Cross Region
% %     [finalTableOut,myCell,crossRegion,inColley,inElo] = inAndOutRegion(Game,Name,PD,Loc,Region,OldName,inElo,eloFirstYear,inOofS,year,HFA);
% %     [eloAdjustments] = logisticFunction(myCell,crossRegion);
%     %% Change values
%     OldName = Name;
%     firstYear = false;
%     %% Print to File (set to true up top)
%     print2FileFunctionCurrent(print2File,Massey,Colley,Elo,year,sport,Name,Game,PD,Loc,NameRecord,IMass,IColl,IElo,OutState,InState);
% 
% %% Normalize Ratings 
%     [~,~,~,averageRating] = normalize_ratings(2019);
%   