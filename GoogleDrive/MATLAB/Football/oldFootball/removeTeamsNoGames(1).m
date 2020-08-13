function [Game,Name,Region,OofS] = removeTeamsNoGames(Game,Name,Region,OofS)
%% Remove teams that have no games

%If there are no games, we want to remove from the game matrix, name matrix, and region matrix
columns = find(sum(abs(Game))==0); %Finds instances where sum of column is 0 
Game(:,columns) = [];
Name(columns) = [];
Region(columns) = [];
OofS(:,columns) = [];

%We don't remove from PD or Loc because there were no games played
