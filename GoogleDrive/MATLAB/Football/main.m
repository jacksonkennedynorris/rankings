function main
clear all 
close all 
sport = "Football";  
for year = 2019 
    [Games,Teams,saveFinal] = loadingMatrices(year); 
    [Games,Teams] = removeTeamsNoGames(Games,Teams);    
    [Games,Teams] = calcs(Games,Teams,year);
end
