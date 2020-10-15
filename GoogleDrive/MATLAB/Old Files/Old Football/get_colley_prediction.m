function predMargin = get_colley_prediction(Game, Colley, Loc, PD)
% rating1 = rating of team1
% rating2 = rating of team2
% loc = location of game with respect to team1 (1=home, 0=away, 2=neutral)
% calculates and returns predicted margin of team1 vs. team2
HFA=0.01;
numGames=length(Loc);
HFA_adj=zeros(size(Loc));

ratings = Game * Colley;

%Add home field advantage constant to the home team's rating 
for i = 1:numGames
    if Loc(i) == 0
        HFA_adj(i) = - HFA;
    elseif Loc(i) == 1
        HFA_adj(i) = HFA;
    end
end

rating_discrep= ratings + HFA_adj;

PD(find(rating_discrep<0))= -PD(find(rating_discrep<0));

rating_discrep=abs(rating_discrep);

scatter(rating_discrep,PD);
lsline

polyfit(rating_discrep,PD,1)

%The equation of the line is what is used for predicted margin




