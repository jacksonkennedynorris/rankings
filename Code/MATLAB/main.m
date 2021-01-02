function main
clear all 
close all 
sport = "Boys Basketball";  

for year = 1999:2020
    [Games,Teams] = loading_data(year,sport);
    [Games,Teams] = calcs(Games,Teams,year,sport);
    [~, Teams] = get_aggregate_ratings(Teams, year,sport); 

    cd('../..')
    if sport == "Football" 
        cd('football')
    elseif sport == "Boys Basketball"
        cd('BBasketball')
    end

    writetable(struct2table(Games), "games_" + num2str(year) + ".csv")
    teams_table = struct2table(Teams); 
    writetable(sortrows(teams_table, 'rating','descend'), "teams_" + num2str(year) + ".csv")
    cd('../Code/MATLAB')
    disp("Finished " + sport + " for year: " + year)
end
