function [newData,Games,Teams] = createGameMat(Games,Teams)
GameMat = zeros(length(Games),length(Teams));
PD = zeros(length(Games),1);
Loc = zeros(length(Games),1);
max_pd = 36;
for elem = length(Games):-1:1
    win = Games(elem).win_id;
    loss = Games(elem).lose_id;
    if Games(elem).overtime 
       pd = 1/2; 
    else
        pd = Games(elem).win_score - Games(elem).lose_score;
        if pd >= max_pd 
           pd = max_pd;
        end
    end
    loc = Games(elem).location;
    if win < 1 || loss < 1
        GameMat(elem,:) = [];
        PD(elem) = []; 
        Loc(elem) = [];
        continue
    else
        GameMat(elem,win) = 1;
        GameMat(elem,loss) = -1;
        PD(elem) = pd;
        Loc(elem) = loc;
    end
end

newData = struct;
newData.Game = GameMat;
newData.PD = PD; 
newData.Loc = Loc;