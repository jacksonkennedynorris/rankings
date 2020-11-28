function [percentCorrectColley] = main_test(years)
%Test the ratings
%% Accumulators

numWeeks = 20;
sport = 'Football';
Elo = zeros(222,1);
firstYear = 0;

% masseyHFA=1.3:0.1:2.7;
% Mass_correct_pred=zeros(length(masseyHFA),1);
HFA_values = 0.003:0.001:0.02;
HFA_rating_values = 0.03:0.01:0.10;
Coll_correct_pred=zeros(length(HFA_values),length(HFA_rating_values));
% Masstotal=zeros(length(masseyHFA),1);
Colltotal=zeros(length(HFA_values),length(HFA_rating_values));

%% Loop through each year to determine if ratings are inline with predictions
for year= years
    year = num2str(year);
    for week=10:numWeeks
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
        
        
        % looping through different HFA values
        i=0;
        for HFA = HFA_values
            i=i+1;
            j=0;
            for HFA_rating = HFA_rating_values
                j=j+1;
                colleyRatings = colleyRatingW(Game,PD,Loc,HFA_rating);


        %% Determine result of game
                for elem = size(Game,1)+1:size(NewGame,1)
                    %Actual result of game 
                    actual_winner=find(NewGame(elem,:)==1);
                    actual_loser=find(NewGame(elem,:)==-1);

                    %% Get Massey ratings
                    %masseyWin=colleyRatings(actual_winner);
                    %collLos=colleyRatings(actual_loser);

                    %% Determine location for HFA and add to accumulators

    %                 %Home team won
    %                 if NewLoc(i)==1
    %                     masseyWin=masseyWin+HFA;
    %                 %Away team won
    %                 elseif NewLoc(i)==0
    %                     masseyWin=masseyWin-HFA; 
    %                 end
    % 
    %                 if masseyWin>masseyLos
    %                     Mass_correct_pred(i)=Mass_correct_pred(i)+1;
    %                     Masstotal(i)=Masstotal(i)+1;
    %                 else
    %                     Masstotal(i)=Masstotal(i)+1;
    %                 end

                    % Get Colley ratings
                    collWin=colleyRatings(actual_winner);
                    collLos=colleyRatings(actual_loser);
                    %% HFA and add to accumulators   
                    if NewLoc(elem)==1
                        collWin=collWin+HFA;
                    elseif NewLoc(elem)==0
                        collWin=collWin-HFA;
                    end

                    if collWin>collLos
                        Coll_correct_pred(i,j)=Coll_correct_pred(i,j)+1;
                        Colltotal(i,j)=Colltotal(i,j)+1;
                    else
                        Colltotal(i,j)=Colltotal(i,j)+1;
                    end

    %                   % Get Elo ratings
    %                 collWin=colleyRatings(actual_winner);
    %                 collLos=colleyRatings(actual_loser);
    %                 %% HFA and add to accumulators   
    %                 if NewLoc(elem)==1
    %                     collWin=collWin+HFA;
    %                 elseif NewLoc(elem)==0
    %                     collWin=collWin-HFA;
    %                 end
    % 
    %                 if collWin>collLos
    %                     Coll_correct_pred(i,j)=Coll_correct_pred(i,j)+1;
    %                     Colltotal(i,j)=Colltotal(i,j)+1;
    %                 else
    %                     Colltotal(i,j)=Colltotal(i,j)+1;
    %                 end

                end
            end
         end
      end

    %% Calculate percentages! 
    %percentCorrectMass= Mass_correct_pred./Masstotal.*100;
    percentCorrectColley= (Coll_correct_pred./Colltotal).*100;
    
end






