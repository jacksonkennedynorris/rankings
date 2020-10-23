function initElo = initialElo(Games, Teams, year) 

if year == 1998 
    initElo = 1500*ones(1,length(Teams));
else
    if ismac 
        Elo = load(strcat('Ratings/',num2str(year-1),'/elorating.txt'));
        initElo = (1/3)*(1500 + 2*Elo);
    elseif ispc
        Elo = load(strcat('Ratings\',num2str(year-1),'\elorating.txt'));
        initElo = (1/3)*(1500 + 2*Elo);
    end
end

initElo = 1500*ones(1,length(Teams));