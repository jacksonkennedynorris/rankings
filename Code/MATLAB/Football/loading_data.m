function [Games, Teams] = loading_data(year,sport) 

info_file = pwd + '/' sport + "/Data/" + num2str(year) + "/game_infos/game_infos";

game_data = readtable(info_file);
Games = table2struct(game_data);

% team_files = pwd + "/Data/" + num2str(year) + "/team_tags/" + num2str(year) + "_Team_Tags";

team_files = pwd + "/" + sport "/Teams/" + num2str(year) + "_teams.txt";
team_list = importdata(team_files);

region_list = team_list.data;
team_list = team_list.textdata(:,1);

%% Remove Covid Games (no winner) 
for elem = length(Games):-1:1
    Games(elem).cross_region = 0;
    if Games(elem).win_score == 0 && Games(elem).lose_score == 0
       Games(elem) = []; 
    end
    if isnan(Games(elem).win_score) || isnan(Games(elem).lose_score)
        Games(elem) = [];
    end
end
%% Find Wins and Losses
Teams = [];
team_list = flip(team_list);
region_list = flip(region_list);
for elem = length(team_list):-1:1
    wins = length(find({Games.win_team}' == string(team_list(elem))));
    losses = length(find({Games.lose_team}' == string(team_list(elem))));
    if wins + losses < 4   %% Remove teams that played fewer than four games
        continue
    end
    temp.name = string(team_list(elem));
    temp.region = region_list(elem);
    temp.rating = 0;
    temp.wins = wins;
    temp.losses = losses; 
    temp.massey = 0; 
    temp.colley = 0; 
    temp.elo = 0; 
    Teams = [Teams; temp];
end

%% Find Out of State Teams 
[~, win] = ismember({Games.win_team}',team_list);
[~, lose] = ismember({Games.lose_team}',team_list); 

for elem = 1:length(win)
    if win(elem) == 0
        Games(elem).win_team = "Out_State";
    end
    if lose(elem) == 0 
        Games(elem).lose_team = "Out_State"; 
    end
end

out_state_win = find([Games.win_team] == "Out_State");
out_state_loss = find([Games.lose_team] == "Out_State");
for game = length(Games):-1:1
    if ismember(game, out_state_win) || ismember(game, out_state_loss)
       Games(game) = [];
       continue
    end
    if Games(game).win_score == 1 %Remove your forfeits
        Games(game) = [];
    end
end