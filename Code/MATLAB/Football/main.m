function main
clear all 
close all 
sport = "Football";  

for year = 2019:2020
    [Games,Teams] = loading_data(year);
    [Games,Teams] = calcs(Games,Teams,year);
    [~, Teams] = get_aggregate_ratings(Teams, year); 

    cd('../../../football')
    writetable(struct2table(Games), "games_" + num2str(year) + ".csv")
    teams_table = struct2table(Teams); 
    writetable(sortrows(teams_table, 'rating','descend'), "teams_" + num2str(year) + ".csv")
    cd('../Code/MATLAB/Football')
    disp("Finished for year: " + year)
end
