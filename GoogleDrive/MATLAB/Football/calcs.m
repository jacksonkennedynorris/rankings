function [Games,Teams] = calcs(Games,Teams,year)

Massey = massey(Games,Teams);
Colley = colley(Games,Teams,0);
Elo = elo(Games,Teams);

if ~exist(num2str(year), 'dir')
   mkdir(num2str(year))
   cd(num2str(year))
   mkdir("rankings") 
   cd('rankings')
else
   cd(num2str(year))
   cd("rankings") 
end

save('eloRating.txt','Elo','-ascii')
save('colleyRating.txt','Colley','-ascii')
save('masseyRating.txt','Massey','-ascii')


cd ../..