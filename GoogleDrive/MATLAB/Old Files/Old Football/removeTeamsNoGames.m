function data = removeTeamsNoGames(data)
%% Remove teams that have no games

%If there are no games, we want to remove from the game matrix, name matrix, and region matrix
columns = find(sum(abs(data.Game))==0); %Finds instances where sum of column is 0 
data.Game(:,columns) = [];
data.Name(columns) = [];
data.Region(columns) = [];
data.OofS(:,columns) = [];
%We don't remove from PD or Loc because there were no games played
