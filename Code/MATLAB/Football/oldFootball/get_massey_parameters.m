function [all_massey_diff]= get_massey_parameters(years)

%Test the ratings
%% Accumulators

numWeeks = 20;
sport = 'Football';
Elo = zeros(222,1);
firstYear = 0;

masseyHFA=2;
all_massey_diff=[];




%% Loop through each year to determine if ratings are inline with predictions
for year= years
    massey_diff=[];
    year = num2str(year);
    for week=8:numWeeks
%% Load matrices for old weeks and weeks+1
        [Game,PD,Loc,~,~,~,OofS,Forfeits] = loadingMatrices(year,sport,week);% Input Year, sport, and week length if applicable
        [Name,Region] = getNameAndRegion(year,sport);
        [Game,NewName,Region,OofS] = removeTeamsNoGames(Game,Name,Region,OofS);
        removed_teams = [];
        for i=1:length(Name)
            if ~ismember(NewName,Name(i))
                removed_teams = [removed_teams; i];
            end
            
        end
        [Game,PD,Loc] = removeForfeits(Game,PD,Loc,Forfeits);
        
     % Get games from next weeks
        [NewGame,NewPD,NewLoc,~,~,~,~,Forfeits] = loadingMatrices(year,sport,week+1);% Input Year, sport, and week length if applicable
         NewGame(:,removed_teams)=[];
        [NewGame,NewPD,NewLoc] = removeForfeits(NewGame,NewPD,NewLoc,Forfeits);
        
        
        week_massey_diff=zeros(size(NewGame,1)-size(Game,1),2);

        masseyRatings = masseyRatingW(Game,PD,Loc,masseyHFA);


    %% Determine result of game
        for elem = size(Game,1)+1:size(NewGame,1)
            i = elem - size(Game,1);
           
            
            %Actual result of game 
            actual_winner=find(NewGame(elem,:)==1);
            actual_loser=find(NewGame(elem,:)==-1);

            if isempty(actual_winner) | isempty(actual_loser)
                continue
            end
                
                
            
            %% Get Massey ratings
            masseyWin=masseyRatings(actual_winner);
            masseyLos=masseyRatings(actual_loser);

            %% Determine location for HFA and add to accumulators

            %Home team won
            if NewLoc(elem)==1
                masseyWin=masseyWin+masseyHFA;
            %Away team won
            elseif NewLoc(elem)==0
                masseyWin=masseyWin-masseyHFA; 
            end

            %Difference in ratings
            %Add to matrix in first column
            
            week_massey_diff(i,1)=abs(masseyWin-masseyLos);

            %Test if the favorite won and add 1/0 to second column
            if masseyWin>masseyLos
                week_massey_diff(i,2)=1;
            else 
                week_massey_diff(i,2)=0;
            end

        end
        
        massey_diff = [massey_diff; week_massey_diff];
    end
    all_massey_diff = [all_massey_diff; massey_diff];
end

[b,dev,stats] = glmfit(all_massey_diff(:,1),all_massey_diff(:,2),'binomial','link','logit','constant','off');
b
XX=linspace(0,50);
yfit=glmval(b,XX,'logit','constant','off');
plot(XX,yfit)