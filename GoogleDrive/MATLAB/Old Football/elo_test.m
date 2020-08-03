function [percentCorrectElo] = elo_test(years)
%Test the ratings
%% Accumulators

numWeeks = 20;
sport = 'Football';

firstYear = true;
OldName=[];

eloHFA=40:2:60;
correct(i)=0;
total(i)=0;

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
        [initElo] = initialElo(Game,firstYear,Elo,Name,OldName,year);
        
     % Get games from next weeks
        [NewGame,NewPD,NewLoc,~,~,~,~,Forfeits] = loadingMatrices(year,sport,week+1);% Input Year, sport, and week length if applicable
         NewGame(:,removed_teams)=[];
        [NewGame,NewPD,NewLoc] = removeForfeits(NewGame,NewPD,NewLoc,Forfeits);
        
        i=0;
        for hfa = eloHFA
            i=i+1;
            ratings=eloRating(Game,PD,Loc,initElo,hfa);


    %% Determine result of game
                for elem = size(Game,1)+1:size(NewGame,1)
                    %Actual result of game 
                    actual_winner=find(NewGame(elem,:)==1);
                    actual_loser=find(NewGame(elem,:)==-1);

                    %% Get Massey ratings
                    Win=ratings(actual_winner);
                    Los=ratings(actual_loser);

                    %% Determine location for HFA and add to accumulators

                    %Home team won
                    if NewLoc(i)==1
                        Win=Win+hfa;
                    %Away team won
                    elseif NewLoc(i)==0
                        Win=Win-hfa; 
                    end

                    if Win>Los
                        correct(i)=correct(i)+1;
                        total(i)=total(i)+1;
                    else
                        total(i)=total(i)+1;
                    end

                end
        end
    end
end

    %% Calculate percentages! 
percentCorrectElo=correct./total.*100;
    
