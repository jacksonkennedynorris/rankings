function initElo = ininitialElo(Game,firstYear,Elo,Name,OldName,year,Region)

if firstYear
    initElo=ones(length(Game(1,:)),1)*1500; %Transpose to be columns
else
    initElo = [];
    for elem = 1:length(Name)
        if ismember(Name(elem),OldName)
            index = find(strcmp(OldName,Name(elem)));
            initElo(elem) = (1/3)*Elo(index) + (2/3)*1500;
        else
            initElo(elem) = 1500;
        end
    end
    initElo = initElo';
end
for elem = 1:length(initElo)
    Name(elem);
    initElo(elem);
end