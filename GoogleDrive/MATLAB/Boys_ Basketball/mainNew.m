function main
clear all
close all
sport = "Boys' Basketball";
for year = 2020
[Games,Teams] = loadingMatrices(year);
[Games,Teams] = modifyData(Games,Teams);
[Games,Teams,dataFinal] = calcs(Games,Teams,year);
%% Normalize Ratings 
[averageRating] = normalize_ratings(sport, year);
writeFinalTable(Games,Teams,averageRating,dataFinal,year)
disp(strcat("Done with Matlab for Year: ", num2str(year)))
end