function [Games,Teams] = modifyData(Games,Teams)
%% Calculate Record
wMat = zeros(length(Teams),1);
lMat = zeros(length(Teams),1); 
inSw = zeros(length(Teams),1); 
inSl = zeros(length(Teams),1); 
for i = 1:length(Games)
    w = Games(i).winID;
    l = Games(i).loseID; 
    if w>0 && l>0
        inSw(w) = inSw(w) + 1; 
        inSl(l) = inSl(l) + 1; 
        wMat(w) = wMat(w) + 1; 
        lMat(l) = lMat(l) + 1; 
    elseif w>0 %Get rid of the out of state teams
        wMat(w) = wMat(w) + 1;
    elseif l>0 %Get rid of the out of state teams
        lMat(l) = lMat(l) + 1; 
    end
end
for record = 1:length(Teams) %Add wins, losses, record to teams
    Teams(record).Record = strcat(num2str(wMat(record)),'-',num2str(lMat(record)));
    Teams(record).inState = strcat(num2str(inSw(record)),'-',num2str(inSl(record)));
    Teams(record).Wins = wMat(record);
    Teams(record).Losses = lMat(record);
    Teams(record).GamesPlayed = wMat(record) + lMat(record); 
end
%% Remove forfeits
for elem = fliplr(find([Games.forfeit] == 1)) %We want to iterate backwards
                                              %through the find because we
                                              %want to delete
    winner = Games(elem).winID;             
    loser = Games(elem).loseID;
    Games(elem) = [];                         

    Teams(winner).GamesPlayed = Teams(winner).GamesPlayed - 1;
    Teams(loser).GamesPlayed = Teams(loser).GamesPlayed - 1;
end
Games = rmfield(Games,'forfeit'); %Remove the forfeit field
%% Change OT Point differentials 
for elem = find([Games.OT] == 1) 
    Games(elem).PD = 1/2;
end
Games = rmfield(Games,'OT');

Games(end)
Teams(end)
%% Remove teams no games
for i = fliplr(find([Teams.GamesPlayed]==0)) %Have to iterate backwards
    Teams(i).teamID = -1 * Teams(i).teamID;
    Teams(i)
end
% Teams = rmfield(Teams,'GamesPlayed');