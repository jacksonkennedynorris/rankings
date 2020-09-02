function [all_colley_diff]= get_colley_parameters(years)



numWeeks = 20;
sport = 'Football';
Elo = zeros(222,1);
firstYear = 0;

colleyHFA=0.03;
colley_ratingsHFA=0.01;
all_colley_diff=[];
all_colley_PD_diff=[];



%% Loop through each year to determine if ratings are inline with predictions
for year= years
    colley_diff=[];
    colley_PD_diff = [];
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
        
        
        week_colley_diff=zeros(size(NewGame,1)-size(Game,1),2);
        week_colley_PD_diff = zeros(size(NewGame,1)-size(Game,1),2);

        colleyRatings = colleyRatingW(Game,PD,Loc,colley_ratingsHFA);


    %% Determine result of game
        for elem = size(Game,1)+1:size(NewGame,1)
            i = elem - size(Game,1);
           
            
            %Actual result of game 
            actual_winner=find(NewGame(elem,:)==1);
            actual_loser=find(NewGame(elem,:)==-1);

            if isempty(actual_winner)||isempty(actual_loser)
                continue
            end
                
                
            
            %% Get Massey ratings
            collWin=colleyRatings(actual_winner);
            collLos=colleyRatings(actual_loser);

            %% Determine location for HFA and add to accumulators

            %Home team won
            if NewLoc(elem)==1
                collWin=collWin+colleyHFA;
            %Away team won
            elseif NewLoc(elem)==0
                collWin=collWin-colleyHFA; 
            end

            %Difference in ratings
            %Add to matrix in first column
            
            week_colley_diff(i,1)=abs(collWin-collLos);
            week_colley_PD_diff(i,1)=week_colley_diff(i,1);
            
            %Test if the favorite won and add 1/0 to second column
            if collWin>collLos
                week_colley_diff(i,2)=1;
                week_colley_PD_diff(i,2)=NewPD(elem);
            else 
                week_colley_diff(i,2)=0;
                week_colley_PD_diff(i,2)=-NewPD(elem);
            end

            %week_colley_PD_diff(i,2)=NewPD(elem);
        end
        
        colley_diff = [colley_diff; week_colley_diff];
        colley_PD_diff = [colley_PD_diff; week_colley_PD_diff];
    end
    all_colley_diff = [all_colley_diff; colley_diff];
    all_colley_PD_diff = [all_colley_PD_diff; colley_PD_diff];
end

% gets line of rating discrepancy vs. PD (hopefully through origin)
scatter(all_colley_PD_diff(:,1),all_colley_PD_diff(:,2));
lsline
polyfit(all_colley_PD_diff(:,1),all_colley_PD_diff(:,2),1)
%fitlm(all_colley_PD_diff(:,1),all_colley_PD_diff(:,2),'Intercept',false)

% gets logisitc regression of rating discrepancy (absolute value) vs. 1/0
% (win/loss)
% [b,dev,stats] = glmfit(all_colley_diff(:,1),all_colley_diff(:,2),'binomial','link','logit','constant','off');
% b
% XX=linspace(0,1);
% yfit=glmval(b,XX,'logit','constant','off');
% plot(XX,yfit)