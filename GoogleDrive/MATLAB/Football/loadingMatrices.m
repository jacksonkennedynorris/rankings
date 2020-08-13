function [Games, Teams, saveFinal] = loadingMatrices(year) 

cd(strcat('../..\HS Sports Data\Football\',num2str(year),'\game_summaries'))

cd('../../../..\MATLAB\Football')
Games = [];
Teams = [];
saveFinal = false; 