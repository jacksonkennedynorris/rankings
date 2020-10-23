function [Teams] = createTeams(Name,Region,District)
%% Create Teams struct with fields Name, Region, District
Teams = [];
for i = 1:length(Name)
    tStruct = struct;
    tStruct.Name = string(Name(i));
    tStruct.teamID = i; 
    tStruct.Record = [];    
    tStruct.Rating = [];
    tStruct.Region = Region(i);
    tStruct.District = District(i); 
    tStruct.Wins = [];
    tStruct.Losses = [];
    tStruct.GamesPlayed = [];
    tStruct.inState = [];
    Teams = [Teams; tStruct];
end
