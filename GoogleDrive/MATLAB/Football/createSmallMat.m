function data = createSmallMat(data)
Players = [];
for elem = 1:length(data.Game)
    win = find(data.Game(elem,:)==1);
    loss = find(data.Game(elem,:)==-1);
    Players = [Players; win, loss, data.PD(elem)];
end
data.Players = Players;
%SmallMat displays winner, then loser in a vector

