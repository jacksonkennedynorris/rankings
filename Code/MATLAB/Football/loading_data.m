function [Games, Teams] = loading_data(year) 

info_file = pwd + "/Data/" + num2str(year) + "/game_infos/game_infos";

game_data = readtable(info_file);
Games = table2struct(game_data);

team_files = pwd + "/Data/" + num2str(year) + "/team_tags/" + num2str(year) + "_Team_Tags";
Teams = importdata(team_files);
