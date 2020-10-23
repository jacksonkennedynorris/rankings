function [newData,Games,Teams] = createGameMat(Games,Teams)
GameMat = zeros(length(Games),length(Teams));
PD = zeros(length(Games),1);
Loc = zeros(length(Games),1);
for elem = length(Games):-1:1
    win = Games(elem).winID;
    loss = Games(elem).loseID;
    pd = Games(elem).PD;
    loc = Games(elem).Loc;
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