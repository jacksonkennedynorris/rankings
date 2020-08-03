function [Games,Teams,ratings] = calcs(Games,Teams,year)
%% Create game matrix and store it in data
%[data,Games,Teams] = createGameMat(Games,Teams);
%% Do Calculations
[Massey,~,~] = masseyRating(Games,Teams);
Colley = colleyRating(Games,Teams,0);
initElo = initialElo(Teams);
Elo = eloRating(Games,Teams,initElo);

lastYearString = num2str(year-1);
yearString = num2str(year);
nameString = strcat(lastYearString,'-',yearString,'/ratings/');
cd(nameString);
save('eloRating.txt','Elo','-ascii')
save('colleyRating.txt','Colley','-ascii')
save('masseyRating.txt','Massey','-ascii')
  
cd ../..