function expected_point_diff = get_massey_prediction(Games, Teams, HFA, Massey)
% rating1 = rating of team1
% rating2 = rating of team2
% loc = location of game with respect to winner (1=home, 0=away, 2=neutral)
% calculates and returns predicted point margin of team1 vs. team2 

expected_point_diff = zeros(length(Games),1); 
for i = 1:length(Games) 
   win_id = Games(i).win_id;
   lose_id = Games(i).lose_id;   

   loc = Games(i).location; 
   
   rating_diff = Massey(win_id) - Massey(lose_id);
   
   if loc == 0 
       expected_point_diff(i) = rating_diff - HFA;
   elseif loc == 1 
       expected_point_diff(i) = rating_diff + HFA;
   elseif loc == 2
       expected_point_diff(i) = rating_diff; 
   end
end