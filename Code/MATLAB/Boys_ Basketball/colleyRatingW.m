function Colley = colleyRatingW(Games,Teams,HFA_rating)

[newData,Games,Teams] = createGameMat(Games,Teams);
Game= newData.Game;

Colley = colleyRating(Games,Teams,HFA_rating);
oldColley = zeros(length(Colley),1);

%% weight calculation
while norm(Colley-oldColley) > .00001

    rating_discrep=Game * Colley;
    predMargin=(68.*rating_discrep)+4;
    
    weights=calc_massey_weights(predMargin,PD);
    
    weightedGame=weights.*Game;
    
    %weightedPD=weights.*PD;
    
    %How to change this to weighted game 
    
    oldColley = Colley;
    Colley=colleyRating(weightedGame,HFA_rating);
    norm(oldColley-Colley);
end

