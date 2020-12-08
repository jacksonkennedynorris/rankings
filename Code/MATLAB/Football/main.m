function main
clear all 
close all 
sport = "Football";  

for year = 2020 %1999:2019
    [Games,Teams] = loading_data(year)
    [Games,Teams] = removeTeamsNoGames(Games,Teams);    
    [Games,Teams] = calcs(Games,Teams,year);
    year
end
%% Test case