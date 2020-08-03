clear all
close all

Name = nflNames();
Game = nflMatrix();
PD = nflDiff();

Loc = eye(length(Name));
Massey = masseyMethod(Game,PD,Loc);
Colley = colleyMethod(Game,PD,Loc);
[Elo,save_data] = eloRating(Game,PD,Loc);

x = save_data;
finalTable=sorter(Name,Massey,Colley,Elo);

%finalTable

