function initElo = initialElo(Games, Teams, year) 

if year == 1998
    initElo = 1500*ones(1,length(Teams));
else
    cd Ratings
    cd(num2str(year-1))
      % Get the Names from last year
        last_table = readtable('eloRating.txt');
        last_name = last_table{:,1};
    cd ..
    cd(num2str(year))
        this_table = readtable('eloRating.txt');
        this_name = this_table{:,1};
        initElo = zeros(length(this_name),1);
        for team_num = 1:length(this_name)
            if ismember(this_name{team_num},last_name) % Team played last year
              % Get the elo for last year
                cd ..
                %region = get_region_from_team_name(year, this_name{team_num});
                last_years_elo = this_table{team_num,2};
              % Bring back towards 1500
                initElo(team_num) = (1/3)*(1500 + 2*last_years_elo);
            else
                initElo(team_num) = 1500;
            end
        end
    cd ..
    cd ..
    initElo = initElo'; % Have to transpose this vector
end

initElo = 1500*ones(1,length(Teams));
