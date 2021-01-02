function [Games,Teams] = removeTeamsNoGames(Games, Teams)

%% Remove teams no games

for i = fliplr(find([Teams.GamesPlayed]==0)) %Have to iterate backwards
    j = i;
    Teams(i) = [];
    while j<length(Teams)
        j = j+1;
        Teams(j).teamID = Teams(j).teamID - 1;
    end
    for game = 1:length(Games)
        if Games(game).winID>j
            Games(game).winID = Games(game).winID - 1;
        end
        if Games(game).loseID>i
            Games(game).loseID = Games(game).loseID - 1;
        end
    end   
end

% Teams = rmfield(Teams,'GamesPlayed');
