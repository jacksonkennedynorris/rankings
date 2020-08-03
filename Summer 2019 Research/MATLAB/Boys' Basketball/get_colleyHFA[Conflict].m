function [percentCorrectColley] = get_colleyHFA
%Test the ratings
%% Accumulators
year = 2020;
numofDays = 92; %rather than the day 
sport = "Boy's Basketball";

%Values added to a win or loss later in this code
HFA_values = 0.002:0.002:0.02;
%Used inside the colley function
HFA_InsideRatingFunction = 0.03:0.01:0.1;

%Create empty vectors for loop
Coll_correct_pred=zeros(length(HFA_values),length(HFA_InsideRatingFunction));
Colltotal=zeros(length(HFA_values),length(HFA_InsideRatingFunction));

%% Loop through each year to determine if ratings are inline with predictions
% for year= years
%     %year = num2str(year);
 for day=35%:numofDays-1
%% Load matrices for old days and days+1
    [Games,Teams,~] = loadingMatrices(year,1:day); 
    [Games,Teams] = modifyData(Games,Teams);
    
%     data = loadingMatrices(year,1:day);
%     data = removeForfeits(data); %Use forfeit function to clean up the data 
%     %Game= data.Game;

    [newGames,newTeams,~] = loadingMatrices(year,day+1); 
    [newGames,newTeams] = modifyData(newGames,newTeams); 

%     New_data = loadingMatrices(year,day+1);
%     New_data = removeForfeits(New_data);
%     NewGame=New_data.Game;
%     NewLoc=New_data.Loc;
    
    i=0;
        for HFA = HFA_values
            i=i+1;
            j=0;
            for HFA_Inside = HFA_InsideRatingFunction
                j=j+1;
                colleyRatings = colleyRating(Games,Teams,HFA_Inside);
%                 colleyRatings = colleyRating(data,HFA_Inside);

        %% Determine result of game
                for elem = 1:length(newGames) 
                    
                    winner = newGames(elem).winID;
                    loser = newGames(elem).loseID;
                    loc = newGames(elem).Loc; 
                    if winner == 0 || loser == 0 %remove out of states
                        continue 
                    end
                    collWin = colleyRatings(winner);
                    collLos = colleyRatings(loser);
                    
                    if loc == 1
                        collWin = collWin - HFA; 
                    elseif loc == 0 
                        collWin = collWin + HFA;
                    end

                    if collWin>collLos
                        Coll_correct_pred(i,j)=Coll_correct_pred(i,j)+1;
                    end
                    Colltotal(i,j)=Colltotal(i,j)+1;
                end
%                 for elem = 1:size(NewGame,1)
%                     %size(Game,1)+1:size(NewGame,1)
%                     %Actual result of game 
%                     actual_winner=find(NewGame(elem,:)==1);
%                     actual_loser=find(NewGame(elem,:)==-1);
% 
%                     % Get Colley ratings
%                     collWin=colleyRatings(actual_winner);
%                     collLos=colleyRatings(actual_loser);
%                     %% HFA and add to accumulators   
%                     if NewLoc(elem)==1
%                         collWin=collWin+HFA;
%                     elseif NewLoc(elem)==0
%                         collWin=collWin-HFA;
%                     end
% 
%                     if collWin>collLos
%                         Coll_correct_pred(i,j)=Coll_correct_pred(i,j)+1;
%                         Colltotal(i,j)=Colltotal(i,j)+1;
%                     else
%                         Colltotal(i,j)=Colltotal(i,j)+1;
%                     end
% 
%                 end
            end
        end
 end 
        
        

%% Calculate percentages!

percentCorrectColley= (Coll_correct_pred./Colltotal).*100

