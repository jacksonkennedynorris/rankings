function initElo = initialElo(Games, Teams, year) 

if year == 1998 
    initElo = 1500*ones(1,length(Teams));
else
    cd Teams 
        lastName = readtable(strcat(num2str(year-1),'_teams.txt'));
        thisName = readtable(strcat(num2str(year),'_teams.txt'));
        [~, index] = ismember(thisName.Name,lastName.Name);
        index
    cd ..
    for i = 1:length(index)
        if index(i) == 0 %% Initialize at 1500 
            i
        end
    end
    if ismac 
      Elo = load(strcat('Ratings/',num2str(year-1),'/elorating.txt'));       
    end
    if ispc
        Elo = load(strcat('Ratings\',num2str(year-1),'\elorating.txt'));
    end
    initElo = (1/3)*(1500 + 2*Elo);
end

