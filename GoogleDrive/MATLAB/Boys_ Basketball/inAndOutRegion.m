function [myCell,crossRegion] = inAndOutRegion(data)%Game,Name,PD,Loc,Region,OldName,inElo,eloFirstYear,inOofS,year,HFA)
Game = data.Game; 
Name = data.Name; 
PD = data.PD; 
Loc = data.Loc; 
Region = data.Region; 

[inGame,outGame,inPD,outPD,inLoc,outLoc,inName,outName,inRegion,outRegion] = regionGames(Game,Name,Region,PD,Loc);
%% Find in region ratings
[inGame,inName,inRegion,outGame,outName,outRegion,outPD,outLoc] = removeTeamsNoRegionGames(inGame,inName,inRegion,outGame,outName,outRegion,outPD,outLoc);

%[inNameRecord] = calculateRecord(inName,inOofS,inGame,inPD,inRegion);
initElo=ones(length(Game(1,:)),1)*1500;
%[ininitElo] = ininitialElo(inGame,eloFirstYear,inElo,inName,OldName,year,Region);
inElo = eloRating(inGame,inPD,inLoc);
%% Juxtapose one region with another 
[myCell,crossRegion] = allRegionsJuxtaposed(outGame,outPD,outLoc,inElo,outRegion,outName);