function [inGame,inName,inRegion,outGame,outName,outRegion,outPD,outLoc] = removeTeamsNoRegionGames(inGame,inName,inRegion,outGame,outName,outRegion,outPD,outLoc)
%% Find the teams that don't play in region and remove them 
inColumn = find(sum(abs(inGame))==0); %This is if the team does not play an in region game
    inColumn = inColumn';
    inGame(:,inColumn) = [];
    inName(inColumn) = [];
    inRegion(inColumn) = [];
%% Find the rows to kill in the out game matrix 
rows2kill = [];
for elem = 1:length(inColumn) 
    row = find(outGame(:,inColumn(elem)));
    rows2kill = [rows2kill;row];
end
%% Kill the rows
outGame(rows2kill,:) = [];
outPD(rows2kill) = [];
outLoc(rows2kill) = [];
%% Remove the teams who don't play in-region from out of region matrices
outGame(:,inColumn) = [];
outName(inColumn) = [];
outRegion(inColumn) = [];  