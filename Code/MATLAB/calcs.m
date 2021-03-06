function [Games,Teams] = calcs(Games,Teams,year,sport)

Massey = massey(Games,Teams,0); %masseyRatingW(Games,Teams,0,sport);
Colley = colley(Games,Teams,0);
Elo = elo(Games,Teams,year,sport);

ratings_dir = pwd + "/" + sport + "/Data/" + num2str(year) + "/Ratings/";
if ~exist(ratings_dir, 'dir')
   mkdir(ratings_dir)
end


Names = {Teams.name}';

massey_table = table(Names, Massey); 
colley_table = table(Names, Colley); 
elo_table = table(Names, Elo);


writetable(massey_table, strcat(ratings_dir + "masseyRating.txt"));
writetable(colley_table, strcat(ratings_dir + "colleyRating.txt")); 
writetable(elo_table, strcat(ratings_dir + "eloRating.txt")); 

