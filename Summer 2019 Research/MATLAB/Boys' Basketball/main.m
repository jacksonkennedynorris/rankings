function main
clear all
close all
sport = "Boys' Basketball";
for year = 2020
[Games,Teams,saveFinal] = loadingMatrices(year);
[Games,Teams] = removeTeamsNoGames(Games,Teams);
[Games,Teams] = calcs(Games,Teams,year);
%% Normalize Ratings
[averageRating] = normalize_ratings(sport, year);
if saveFinal
    writeFinalTable(Games,Teams,averageRating,year)
end
disp(strcat("Done with Matlab for Year: ", num2str(year)))
end
