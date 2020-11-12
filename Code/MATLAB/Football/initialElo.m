function initElo = initialElo(Games, Teams, year) 

if year == 1998 
    initElo = 1500*ones(1,length(Teams));
else
    cd Teams 
        lastName = readtable(strcat(num2str(year-1),'_teams.txt'));
        thisName = readtable(strcat(num2str(year),'_teams.txt'));
        [~, index] = ismember(lastName.Name, thisName.Name);
        index
        %merged = innerjoin(lastName,thisName, 
    cd ..
    if ismac 
       for i = 1:length(index)
            if index[i] == 0
                i
            end
        end
      Elo = load(strcat('Ratings/',num2str(year-1),'/elorating.txt'));
       initElo = (1/3)*(1500 + 2*Elo);       
    end
    if ispc
        Elo = load(strcat('Ratings\',num2str(year-1),'\elorating.txt'));
        initElo = (1/3)*(1500 + 2*Elo);
    end
end

