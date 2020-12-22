function [Games,cross_games] = crossRegion(Games, Teams, year)



cross_region = nchoosek(1:max([Teams.region]),2); 
cross_games = [];
for game = 1:length(Games) 
   
   winner = Games(game).win_team;
   loser = Games(game).lose_team;
  
   win_id = find([Teams.name]' == winner);
   lose_id = find([Teams.name]' == loser);
   
   win_region = Teams(win_id).region;
   lose_region = Teams(lose_id).region;
   
   if win_region ~= lose_region 
       for elem = 1:length(cross_region)
           if win_region == cross_region(elem,1) && lose_region == cross_region(elem,2)
               Games(game).cross_region = elem;
               cross_games = [cross_games; Games(game)];
           elseif win_region == cross_region(elem,2) && lose_region == cross_region(elem,1)
               Games(game).cross_region = -1 * elem;
               cross_games = [cross_games; Games(game)];
           end           

           
       end
   end
end

