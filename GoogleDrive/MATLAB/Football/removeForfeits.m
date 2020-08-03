function [game] = removeForfeits(game)
%% Iterate through Game function to find if there were any forfeitures
%Have to iterate backwards because if we remove one then we have to correct
Game = game.Game; 
PD = game.PD; 
Loc = game.Loc; 
Forfeits = game.forfeits; 
column = find(Forfeits == 1);
Game(column,:) = [];
PD(column) = []; 
Loc(column) = []; 
Forfeits(column) = []; 
game.Game = Game; 
game.PD = PD; 
game.Loc = Loc; 
game.forfeits = Forfeits; 



      