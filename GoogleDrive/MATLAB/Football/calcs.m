function [Games,Teams] = calcs(Games,Teams,year)

Massey = massey(Games,Teams);
Colley = colley(Games,Teams,0);
Elo = elo(Games,Teams);


%% Added a comment
