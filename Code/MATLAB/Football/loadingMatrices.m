function [Games, Teams, saveFinal] = loadingMatrices(year) 
cd('Data')
cd(num2str(year))

summariesFolder = dir("game_summaries"); % Get all file names for summaries
cd("game_summaries")
names = []; 
summaries = []; 
for elem = 1:length(summariesFolder) 
    if contains(summariesFolder(elem).name,'txt')
        s = summariesFolder(elem).name;
        summaries = [summaries; load(s)]; 
        names = [names; s]; 
    end
end
    
cd ../../..
teamTagsFolder = dir("Teams");
cd('Teams');
for elem = 1:length(teamTagsFolder) 
    if contains(teamTagsFolder(elem).name,num2str(year))
        t = teamTagsFolder(elem).name; 
        teams = readtable(t);
    end
end
teams.Properties.VariableNames = {'TeamName','Region'};

Name = teams.TeamName;
Region = teams.Region;


%% Create Games and Teams 
Games = [];
summaries(:,1) = summaries(:,1) + 1;
summaries(:,2) = summaries(:,2) + 1;
for game = 1:length(summaries)
    row = summaries(game,:);
    tStruct = struct;
    if row(1) == 0 
        tStruct.Winner = "OUT_STATE";
    else    
        tStruct.Winner = string(Name(row(1)));
    end
    if row(2) == 0
        tStruct.Loser = "OUT_STATE";
    else
        tStruct.Loser = string(Name(row(2)));
    end
    if row(6) == 0 
        tStruct.Location = tStruct.Loser; 
    elseif row(6) == 1
        tStruct.Location = tStruct.Winner;
    elseif row(6) == 2
        tStruct.Location = "Neutral"; 
    end
    tStruct.winScore = row(3); 
    tStruct.loseScore = row(4); 
    tStruct.winID = row(1);
    tStruct.loseID = row(2); 
    tStruct.PD = row(5);
    if row(7) == 1 
        tStruct.Overtime = 'True'; 
        
    elseif row(7) == 0
        tStruct.Overtime = 'False'; 
    end
    if row(8) == 0
        tStruct.GameType = "Regular Season"; 
    else 
        tStruct.GameType = "Playoff"; 
    end  
    if row(3) == 1
        tStruct.Forfeit = "True"; 
    else 
        tStruct.Forfeit = "False"; 
    end
    tStruct.Loc = row(6);
    Games = [Games; tStruct];%Games(end+1) = tStruct;
end
Teams = [];
for i = 1:length(Name)
    tStruct = struct;
    tStruct.Name = string(Name(i));
    tStruct.teamID = i; 
    tStruct.Record = "";    
    tStruct.Rating = [];
    tStruct.Region = Region(i);
    tStruct.Wins = 0;
    tStruct.Losses = 0;
    tStruct.GamesPlayed = 0;
    tStruct.inStateW = 0;
    tStruct.inStateL = 0; 
    tStruct.inStateRecord = "";
    Teams = [Teams; tStruct];
end

cd .. 

for game = 1:length(Games) 
    winner = Games(game).winID;
    loser = Games(game).loseID;
    if winner > 0
        Teams(winner).Wins = Teams(winner).Wins + 1;
        if loser > 0 
            Teams(winner).inStateW = Teams(winner).inStateW + 1;
            Teams(winner).GamesPlayed = Teams(winner).GamesPlayed + 1;
        end
    end
    if loser > 0 
        Teams(loser).Losses = Teams(loser).Losses + 1;
 
        if winner > 0 
            Teams(loser).inStateL = Teams(loser).inStateL + 1;
            Teams(loser).GamesPlayed = Teams(loser).GamesPlayed + 1;
        end
    end        
end
for team = 1:length(Teams) 
    Teams(team).Record = strcat(num2str(Teams(team).Wins),'-',num2str(Teams(team).Losses));
    Teams(team).inStateRecord = strcat(num2str(Teams(team).inStateW),'-',num2str(Teams(team).inStateL));
end
Teams = rmfield(Teams,'Wins');
Teams = rmfield(Teams,'Losses');
Teams = rmfield(Teams,'inStateW');
Teams = rmfield(Teams,'inStateL');
for game = length(Games):-1:1
    if Games(game).Forfeit == "True" 
        winner = Games(game).winID;
        loser = Games(game).loseID;
        if winner > 0 && loser > 0 
            Teams(winner).GamesPlayed = Teams(winner).GamesPlayed - 1; 
            Teams(loser).GamesPlayed = Teams(loser).GamesPlayed - 1; 
        elseif winner > 0 
            Teams(winner).GamesPlayed = Teams(winner).GamesPlayed - 1; 
        elseif loser > 0 
            Teams(loser).GamesPlayed = Teams(loser).GamesPlayed - 1; 
        end
        Games(game) = [];
        continue
    end
    if Games(game).Overtime == "True" 
        Games(game).PD = 1/2;
    end
end
Games = rmfield(Games,"Forfeit");

saveFinal = false; 