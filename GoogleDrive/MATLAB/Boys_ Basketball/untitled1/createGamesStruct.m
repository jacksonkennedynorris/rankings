function Games = createGamesStruct(summaries,Name,gamesInDay,date,year)
%% Create Games array of structs
Games = struct('Winner',{},'Loser',{},'Date',{},'PD',{},'Location',{},'Loc',{},'winScore',{},'loseScore',{},'winID',{},'loseID',{},'forfeit',{},'OT',{},'GameType',{});

summaries(:,1) = summaries(:,1) + 1;
summaries(:,2) = summaries(:,2) + 1;

%% COMMENT OUT WHEN PIARIST SCHOOL FINALLY REMOVED PROPERLY 
if year == 2020 && max(summaries(:,1)) == 272
    for game = length(summaries):-1:1
        if summaries(game, 2) == 204
            summaries(game,:) = [];
            continue
        end
        if summaries(game, 1) > 204 
            summaries(game, 1) = summaries(game, 1) - 1;
        end
        if summaries(game, 2) > 204
            if summaries(game,2) == 272
            end
            summaries(game, 2) = summaries(game, 2) - 1; 
        end
    end
end
%% Now back to the action
for elem = 1:length(summaries)%:-1:1
    
    
    row = summaries(elem,:);
    tStruct = struct;
    

    if row(1) > 0
        tStruct.Winner = string(Name(row(1)));       
    else
        tStruct.Winner = "OUT_STATE";
    end
    if row(2) > 0 
        tStruct.Loser = string(Name(row(2)));
    else 
        tStruct.Loser = "OUT_STATE";
    end
    
    while gamesInDay(1) == 0 
        gamesInDay(1) = [];
        date(1) = [];
    end
    gamesInDay(1) = gamesInDay(1) - 1; 
    
    tStruct.Date = date(1); 
    tStruct.PD = row(5);
    if row(6) == 0 
        tStruct.Location = tStruct.Loser;
    elseif row(6) == 1
        tStruct.Location = tStruct.Winner;
    elseif row(6) == 2
        tStruct.Location = "Neutral"; 
    end
    tStruct.Loc = row(6);
    tStruct.winScore = row(3);
    tStruct.loseScore = row(4);
    tStruct.winID = row(1);
    tStruct.loseID = row(2);
    if row(3) == 2
        tStruct.forfeit = true;
    else
        tStruct.forfeit = false;
    end
    tStruct.OT = row(7); 
    tStruct.GameType = row(8); 
    Games(end+1) = tStruct; 
end