clear all
close all
sport = 'Football';firstYear = true;OldName = [];inOofS = [];outOofS = [];eloFirstYear = true;inElo = [];Elo = [];eloAdjustments = [];print2File = true;

yearMat = [2013:2018];
myLength = length(yearMat);

prevYear = min(yearMat)-1;
GameCell = cell(myLength,1);
PDCell = cell(myLength,1);
LocCell = cell(myLength,1); 
NameCell = cell(myLength,1); 
OofSCell = cell(myLength,1);
ForfeitsCell = cell(myLength,1); 
RegionCell = cell(myLength,1); 
NameRecordCell = cell(myLength,1); 
OutStateCell = cell(myLength,1); 
InStateCell = cell(myLength,1); 

for year = yearMat
    elem = year - prevYear;
    year = num2str(year);
        %% Get all matrices
    [Game,PD,Loc,~,~,~,OofS,Forfeits] = loadingMatrices(year,sport);% Input Year, sport, and week length if applicable
    [Name,Region] = getNameAndRegion(year,sport);
    [Game,Name,Region,OofS] = removeTeamsNoGames(Game,Name,Region,OofS);
    [NameRecord,Name,OutState,InState] = calculateRecord(Name,OofS,Game,PD,Region);   
    [Game,PD,Loc,Forfeits] = removeForfeits(Game,PD,Loc,Forfeits); 
    
    GameCell{elem} = Game;
    PDCell{elem} = PD;
    LocCell{elem} = Loc;
    NameCell{elem} = Name;
    OofSCell{elem} = OofS;
    ForfeitsCell{elem} = Forfeits;
    RegionCell{elem} = Region;
    NameRecordCell{elem} = NameRecord;
    OutStateCell{elem} = OutState;
    InStateCell{elem} = InState;
end

allSaveData = [];
for s = 200:10:400
    for k = 20:4:60
        for hfa = 10:2:40
            firstYear = true;
for year = yearMat
    %% Call the data
    elem = year-prevYear;
    Game = GameCell{elem,1};
    PD = GameCell{elem,1};
    Loc = LocCell{elem,1};
    Name = NameCell{elem,1};
    OofS = OofSCell{elem,1};
    Forfeits = OofSCell{elem,1};
    Region = RegionCell{elem,1}; 
    NameRecord = NameRecordCell{elem,1};
    OutState = OutStateCell{elem,1};
    InStateCell = InState{elem,1};
    year = num2str(year);
    
    
     [initElo] = initialElo(Game,firstYear,Elo,Name,OldName,year,Region,sport);
    % Ratings!!
    HFA = 0;
%     Massey = masseyRatingW(Game,PD,Loc,HFA);
%     Colley = colleyRatingW(Game,PD,Loc,HFA);
    
    [Elo,save_data(elem,:)] = eloRatingInWork(Game,PD,Loc,initElo,hfa,Name,year,s,k);
%     if year == prevYear + 1
%         save_data = [];
%     %x = [x, save_data];
%     end
    %% Change values
    OldName = Name;
    firstYear = false;

end

x = sum(save_data(2:6,:))/(elem-1);

allSaveData = [allSaveData; x];

        end
    end
end
allSaveData
%sorted = sortrows(allSaveData,5) 


% 
% for s = 200:10:400
%     for k = 20:4:60
%         for hfa = 10:2:40
%             firstYear = true;
% for year = [2013:2018]
%     %% Call the data
%     elem = year-2012;
%     Game = GameCell{elem,1};
%     PD = GameCell{elem,1};
%     Name = NameCell{elem,1};
%     OofS = OofSCell{elem,1};
%     Forfeits = OofSCell{elem,1};
%     Region = RegionCell{elem,1}; 
%     NameRecord = NameRecordCell{elem,1};
%     OutState = OutStateCell{elem,1};
%     InStateCell = InState{elem,1};
%     year = num2str(year);
%  %% Initialize ratings   
% %     [initElo] = initialElo(Game,firstYear,Elo,Name,OldName,year,Region,sport);
% %     numYear = year;
% %     year = num2str(year);
% %     [Game,PD,Loc,~,~,~,OofS,Forfeits] = loadingMatrices(year,sport);% Input Year, sport, and week length if applicable
% %     [Name,Region] = getNameAndRegion(year,sport);
% %     [Game,Name,Region,OofS] = removeTeamsNoGames(Game,Name,Region,OofS);
% %     [NameRecord,Name,OutState,InState] = calculateRecord(Name,OofS,Game,PD,Region);     
% %     [Game,PD,Loc] = removeForfeits(Game,PD,Loc,Forfeits);
%      [initElo] = initialElo(Game,firstYear,Elo,Name,OldName,year,Region,sport);
%     %% Ratings!!
% %     HFA = 0;
% %     Massey = masseyRatingW(Game,PD,Loc,HFA);
% %     Colley = colleyRatingW(Game,PD,Loc,HFA);
%     
%     [Elo,save_data(:,:,elem)] = eloRatingInWork(Game,PD,Loc,initElo,hfa,Name,year,s,k);
%     %x = [x, save_data];
%     %% Generate and print tables
% %     [A1,A2,A3,A4,A5,A6,total,IMass,IColl,IElo] = sortByRegion(NameRecord,Region,Massey,Colley,Elo,year);
%     
%     %% Work on Cross Region
% %     [finalTableOut,myCell,crossRegion,inColley,inElo] = inAndOutRegion(Game,Name,PD,Loc,Region,OldName,inElo,eloFirstYear,inOofS,year,HFA);
% %    [eloAdjustments] = logisticFunction(myCell,crossRegion);
%     %% Change values
%     OldName = Name;
%     firstYear = false;
%     %% Print to File (set to true up top)
%     print2FileFunction(print2File,Massey,Colley,Elo,year,eloAdjustments,sport,Name,Game,PD,Loc,inColley,inElo,NameRecord,IMass,IColl,IElo,OutState,InState);
%     
% end
% x = sum(save_data,3)/(numYear-2012)
% sorted = sortrows(x,5)
%         end
%     end
% end
