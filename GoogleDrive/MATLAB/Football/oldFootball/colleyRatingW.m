function Colley = colleyRatingW(Game,PD,Loc,HFA_rating)
            

Colley = colleyRating(Game,PD,Loc,HFA_rating);
oldColley = zeros(length(Colley),1);

%% weight calculation
while norm(Colley-oldColley) > .00001

    rating_discrep=Game * Colley;
    predMargin=(68.*rating_discrep)+4;
    
    weights=calc_massey_weights(predMargin,PD);
    
    weightedGame=weights.*Game;
    
    %weightedPD=weights.*PD;
    
    oldColley = Colley;
    Colley=colleyRating(weightedGame,PD,Loc,HFA_rating);
    norm(oldColley-Colley);
end

