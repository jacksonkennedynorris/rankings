function [Games,Teams] = calcs(Games,Teams,year)

% Massey = massey(Games,Teams,2.3);
% Colley = colley(Games,Teams,0);
Elo = elo(Games,Teams,year);

ratings_dir = pwd + "/Data/" + num2str(year) + "/Ratings/";
if ~exist(ratings_dir, 'dir')
   mkdir(ratings_dir)
end

Names = [Teams.name]';

massey_table = table(Names, Massey); 
colley_table = table(Names, Colley); 
elo_table = table(Names, Elo);


writetable(massey_table, strcat(ratings_dir + "masseyRating.txt"));
writetable(colley_table, strcat(ratings_dir + "colleyRating.txt")); 
writetable(elo_table, strcat(ratings_dir + "eloRating.txt")); 

