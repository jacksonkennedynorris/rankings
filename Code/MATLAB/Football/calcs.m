function [Games,Teams] = calcs(Games,Teams,year)

Massey = massey(Games,Teams);
Colley = colley(Games,Teams,0);
Elo = elo(Games,Teams,year);
 


if ~exist(num2str(year), 'dir')
   mkdir(num2str(year))
   cd(num2str(year))
else
   cd(num2str(year))
end

Names = [Teams.Name]';
massey_table = table(Names, Massey); 
colley_table = table(Names, Colley); 
elo_table = table(Names, Elo);

writetable(massey_table, "masseyRating.txt");
writetable(colley_table, "colleyRating.txt"); 
writetable(elo_table, "eloRating.txt"); 

cd ../..
