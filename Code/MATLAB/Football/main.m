function main
clear all 
close all 
sport = "Football";  

for year = 2004:2020
    [Games,Teams] = loading_data(year);   
    [Games,Teams] = calcs(Games,Teams,year);
end
%% Test case