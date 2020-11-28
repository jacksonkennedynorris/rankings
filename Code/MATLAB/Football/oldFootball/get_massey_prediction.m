function EPD = get_massey_prediction(Game, Ratings, Loc)
% rating1 = rating of team1
% rating2 = rating of team2
% loc = location of game with respect to team1 (1=home, 0=away, 2=neutral)
% calculates and returns predicted point margin of team1 vs. team2

HFA = 2;


EPD_Neut = Game * Ratings;
HFA_adj = zeros(size(Loc));
num_games = length(Loc);

for i = 1:num_games
    if Loc(i) == 0
        HFA_adj(i) = - HFA;
    elseif Loc(i) == 1
        HFA_adj(i) = HFA;
    end
end


EPD = EPD_Neut + HFA_adj;