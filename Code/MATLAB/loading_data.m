function [Games, Teams] = loading_data(year,sport) 
% This function takes the game infos and calculates the structs for Games
% and Teams. It also calculates the records and removes all teams that do
% not have a sufficient number of games. 

%% ### How many in-state games that ARE NOT forfeits should we consider?
min_games = 0; % Change this number to increase/decrease minimum number of games required for a rating. 

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

    % Remove out of state
    if winner == "Out of State" 
        
        loser = Games(elem).lose_id;
        Teams(loser).games_played = Teams(loser).games_played - 1;
        Games(elem) = []; 
    elseif loser == "Out of State" 
        winner = Games(elem).win_id; 
        Teams(winner).games_played = Teams(winner).games_played-1;
        Games(elem) = []; 
    % Remove forfeits 
    elseif Games(elem).win_score == 1 || Games(elem).win_score == 2 || Games(elem).win_score == 0 %Remove forfeits
        winner = Games(elem).win_id; 
        loser = Games(elem).lose_id;
        if Games(elem).win_score == 0 
            Teams(winner).wins = Teams(winner).wins - 1;
            Teams(loser).losses = Teams(loser).losses -1;
        end
        Teams(winner).games_played = Teams(winner).games_played - 1; 
        Teams(loser).games_played = Teams(loser).games_played - 1; 
        Games(elem) = [];
    end
    
end


%% Remove teams with fewer than x games played 
for team = length(Teams):-1:1
    if Teams(team).games_played < min_games
        disp(" ")
        disp(Teams(team).name + " was removed for insufficient data. ")
        disp(" ")
        Teams(team) = [];
        for i = team:length(Teams) 
            Teams(i).id = Teams(i).id - 1;
        end
        for game = length(Games):-1:1
            %Games(game)
            if Games(game).win_id > team 
                Games(game).win_id = Games(game).win_id - 1;
            end
            if Games(game).lose_id > team 
                Games(game).lose_id = Games(game).lose_id - 1;
            end
            if Games(game).win_id == team
                Games(game) = [];
            elseif Games(game).lose_id == team
                Games(game) = [];
            end
            

        end
    end
end