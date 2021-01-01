function [Games, initElo] = initialElo(Games, Teams, year) 


%[Games,cross_games] = crossRegion(Games,Teams,year);
if year == 1998
    initElo = 1500*ones(1,length(Teams))';
else
    last_year_dir = pwd + "/Data/" + num2str(year-1) + "/Ratings/";
    this_year_dir = pwd + "/Data/" + num2str(year) + "/Ratings/"; 
      % Get the Names from last year
    last_table = readtable(last_year_dir + "eloRating.txt");
    last_name = last_table{:,1};

    this_name = {Teams.name}';
    %this_table = readtable(this_year_dir + "eloRating.txt");
    %this_name = this_table{:,1};
    initElo = zeros(length(this_name),1);
    for team_num = 1:length(this_name)
        [~,a] = ismember(this_name{team_num},last_name);
        if a ~= 0
            last_years_elo = last_table{a,2};
            initElo(team_num) = (1/3)*(1500 + 2*last_years_elo);
        else
            initElo(team_num) = 1500;
        end
    end
   % Have to transpose this vector
end
