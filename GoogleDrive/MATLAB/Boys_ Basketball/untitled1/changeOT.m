function [Games, Teams] = changeOT(Games,Teams)
for elem = find([Games.OT] == 1) 
    Games(elem).PD = 1/2;
end
Games = rmfield(Games,'OT');
