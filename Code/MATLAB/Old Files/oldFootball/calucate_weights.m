function weight = calucate_weights(predMargin,actualMargin,weeksAgo)
% predMargin = predicted point margin between the two teams (always
% positive, since it is calculated by favorite minus underdog)
% actualMargin = actual point margin for the game (favorite minus underdog,
% so positive if the favorite team won; negative if the underdog won)
% weeksAgo = ti
% A weight function that decreases exponentially with the product 
% of the expected and actual margins, whenever the favored team wins.
% If the underdog wins, weight is given as 1.
% Also, weight recent games more heavily.
% Finally, multiply the margin-based weights by the time-based weights
% to compute the weight for a particular game. 

% decay constants -- need to optimize
k1 = 5; % margin-based decay constant for predMargin
k2 = 5; % margin-based decay constant for actualMargin
alpha = .95 % time-based decay constant

if actualMargin < 0 % if game was an upset, give game full weight of 1
    marg_weight = 1;
else
    marg_weight = 1 - (1-exp(-predMargin/k1)).*(1-exp(-actualMargin/k2));
end

time_weight = alpha^weeksAgo;

weight = marg_weight*time_weight;