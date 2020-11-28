function weights = calc_massey_weights(predMargins,actualMargins)
% predMargins = vector of predicted point margins between the two teams 
% (in terms of the winner, so it will be negative if the underdog won)
% actualMargins = vector of actual point margins for the game (in terms of
% the winner, so always positive)
% weeksAgo = weeks elapsed since that game
% A weight function that decreases exponentially with the product 
% of the expected and actual margins, whenever the favored team wins.
% If the underdog wins, weight is given as 1.
% Also, weight recent games more heavily.
% Finally, multiply the margin-based weights by the time-based weights
% to compute the weight for a particular game. 

% decay constants -- need to optimize
k1 = 20; % margin-based decay constant for predMargin
k2 = 20; % margin-based decay constant for actualMargin
%alpha = .95 % time-based decay constant

%Predicted margin is just the minuend between ratings?
%How do we know which one the favored team is?
%Do we need matrix we are reading in as a parameter?

marg_weights = zeros(size(predMargins));
marg_weights(find(predMargins <= 0)) = 1; % if game was an upset, give game full weight of 1

fav_winners = find(predMargins > 0);

% weights similar to Drew's paper
%marg_weights(fav_winners) = 1 - (1-exp(-predMargins(fav_winners)/k1)).*(1-exp(-actualMargins(fav_winners)/k2));

% S-curve weights
%marg_weights(fav_winners) = 1 - (1-exp(-predMargins(fav_winners)/k1)).*(1-exp(-actualMargins(fav_winners)/k2));

%Better S-curve  
marg_weights(fav_winners)=(1-1./(1+exp(-(min(predMargins(fav_winners),actualMargins(fav_winners))-35)/3)));


% ############ ignoring time-based weights for now
%time_weight = alpha^weeksAgo;

%weight = marg_weight*time_weight;
weights = marg_weights;