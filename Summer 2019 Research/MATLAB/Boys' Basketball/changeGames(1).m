function game = changeGames(game)
%This function changes the PD of overtime wins to 0.5, removes forfeits,
%and removes team who have played no games
%% Change overtime
overtime = find(game.OT == 1);
game.PD(overtime) = 1/2;
%% Remove forfeits
forfeit = find(game.Forfeits == 1);
game.Game(forfeit,:) = [];
game.PD(forfeit) = []; 
game.Loc(forfeit) = []; 
game.Forfeits(forfeit) = [];
game.Name(end);
%% Remove teams that have no games
%If there are no games, we want to remove from the game matrix, name matrix, and region matrix
noGames = find(sum(abs(game.Game))==0) %Finds instances where sum of column is 0 
game.Game(:,noGames) = [];

%game.Name(noGames) = []; %comment back later 
% Region(noGames) = [];
game.OofS(:,noGames) = [];

for elem = 1:length(game.Game(1,:))
    if sum(game.Game(:,elem)) == 0
        game.Name(elem);
    end
end
find(sum(abs(game.Game))==0);


%We don't remove from PD or Loc because there were no games played