function writeFinalTable(Games,Teams,averageRating,year)


for elem = 1:length(Teams) 
    Teams(elem).Rating = round(averageRating(elem),2);
end

final = struct2table(Teams);
final = sortrows(final,4,'descend');
gamesFinal = struct2table(Games);
cd("../../../BBasketball")

writetable(final,strcat(num2str(year),"table.csv"));
writetable(gamesFinal,strcat(num2str(year),"games.csv"));
cd("../GoogleDrive/MATLAB/Boys_ Basketball")

disp("Saved to file.")