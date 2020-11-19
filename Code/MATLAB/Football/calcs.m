function [Games,Teams] = calcs(Games,Teams,year)

Massey = massey(Games,Teams,2.3);
Colley = colley(Games,Teams,0);
Elo = elo(Games,Teams,year);
 
cd('Ratings') 

if ~exist(num2str(year), 'dir')
   mkdir(num2str(year))
   cd(num2str(year))
else
   cd(num2str(year))
end

save('eloRating.txt','Elo','-ascii')
save('colleyRating.txt','Colley','-ascii')
save('masseyRating.txt','Massey','-ascii')

cd ../..
