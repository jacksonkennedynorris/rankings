function game = changeGames(game)
%% Change overtime
for elem = 1:length(game.OT) 
    if game.OT(elem) == 1
        game.PD(elem) = 1/2;
    end
end
%% Remove forfeits
for elem = length(game.Game):-1:1 
    if game.Forfeits(elem) == 1 
        game.Game(elem,:) = [];
        game.PD(elem) = [];
        game.Loc(elem) = [];
        game.Forfeits(elem) = [];
    end
end
