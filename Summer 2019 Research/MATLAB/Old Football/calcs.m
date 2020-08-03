function [data] = calcs(data,initElo)

Game = data.Game; 
PD = data.PD; 
Loc = data.Loc; 
HFA = 2;
Massey = masseyRatingW(Game,PD,Loc,HFA);
HFA = .03;
Colley = colleyRatingW(Game,PD,Loc,HFA);
Elo = eloRating(Game,PD,Loc,initElo);

data.Massey = Massey; 
data.Colley = Colley; 
data.Elo = Elo; 
