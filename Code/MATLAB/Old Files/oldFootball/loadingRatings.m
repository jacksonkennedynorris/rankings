function [Massey,Colley,Elo,EloAdjustments] = loadingRatings(year,sport)
masseyFile = strcat(sport,'/',year,'/ratings/masseyRating.txt');
colleyFile = strcat(sport,'/',year,'/ratings/colleyRating.txt');
eloFile = strcat(sport,'/',year,'/ratings/eloRating.txt');
eloAdjustmentsFile = strcat(sport,'/',year,'/ratings/eloAdjustments.txt');

Massey = load(masseyFile);
Colley = load(colleyFile); 
Elo = load(eloFile); 
EloAdjustments = load(eloAdjustmentsFile); 
%EloAdjustments = [];
