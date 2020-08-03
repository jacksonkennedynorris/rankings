function [Games,Teams] = removeForfeits(Games,Teams)
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