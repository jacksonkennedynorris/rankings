
year = 2021; 
sport = "Boys Basketball";
%% 
info_file = pwd + "/" + sport + "/Data/" + num2str(year) + "/game_infos/game_infos";

game_data = readtable(info_file);
Games = table2struct(game_data);

team_files = pwd + "/" + sport + "/Teams/" + num2str(year) + "_teams.txt";
team_table = readtable(team_files);

Teams = table2struct(team_table);


%% Initialize the teams 
for team_id = 1:length(Teams) 
    Teams(team_id).id = team_id;
    Teams(team_id).rating = 0;
    Teams(team_id).massey = 0; 
    Teams(team_id).colley = 0; 
    Teams(team_id).elo = 0; 
    Teams(team_id).wins = 0; 
    Teams(team_id).losses = 0; 
    Teams(team_id).games_played = 0; 
end
%% Fix all extreme cases 
for elem = length(Games):-1:1
    % Used to initialize a cross-region game
    Games(elem).cross_region = 0;
    
    % Remove covid games no victor 
    if Games(elem).win_score == 0 && Games(elem).lose_score == 0
       Games(elem) = []; 
       continue
    end
    % Remove games with a - instead of a score
    if isnan(Games(elem).win_score) || isnan(Games(elem).lose_score)
        Games(elem) = [];
        continue
    end
    
    winner = Games(elem).win_team;
    loser = Games(elem).lose_team; 
    
    % Change records of teams who played
    for team = 1:length(Teams) 
        % Strcmp compares strings. Annoyingly, matlab wasn't letting me
        % does this without this function. 
            name_and_win = strcmp(Teams(team).name, winner);
            name_and_loss = strcmp(Teams(team).name,loser);
        
        if name_and_win
            Teams(team).wins = Teams(team).wins + 1;
            Games(elem).win_id = Teams(team).id;
            Teams(team).games_played = Teams(team).games_played + 1;
        elseif name_and_loss
            Teams(team).losses = Teams(team).losses + 1; 
            Games(elem).lose_id = Teams(team).id; 
            Teams(team).games_played = Teams(team).games_played + 1;
        end
    end
end
table = {}
for Team = 1:length(Teams)
    if Teams(Team).games_played == 0 
        table{end+1} = Teams(Team).name
    end
end
writecell(table',"file.csv")