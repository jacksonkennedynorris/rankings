function [Game,PD,Loc,Forfeits] = removeForfeits(Game,PD,Loc,Forfeits)
%% Iterate through Game function to find if there were any forfeitures
%Have to iterate backwards because if we remove one then we have to correct

for elem = length(Game):-1:1 
    if Forfeits(elem) == 1 
        Game(elem,:) = [];
        PD(elem) = [];
        Loc(elem) = [];
        Forfeits(elem) = [];
    end
end


      