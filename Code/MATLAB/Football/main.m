function main
clear all 
close all 
sport = "Football";  

for year = 1999:2019
    [Games,Teams,saveFinal] = loadingMatrices(year); 
    [Games,Teams] = removeTeamsNoGames(Games,Teams);    
    [Games,Teams] = calcs(Games,Teams,year);
    year
end
%% Test case