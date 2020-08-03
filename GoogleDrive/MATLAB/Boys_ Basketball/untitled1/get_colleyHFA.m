function [percentCorrectColley] = get_colleyHFA(year)
%Test the ratings
%% Accumulators

numofDays = 92; %rather than the day 
sport = "Boy's Basketball";

%Values added to a win or loss later in this code
HFA_values = 0.002:0.001:0.02; %0.02:0.002:0.05;
%Used inside the colley function
HFA_InsideRatingFunction = 0.03:0.01:0.1; %0.03:0.01:0.1;

%Create empty vectors for loop
Coll_correct_pred=zeros(length(HFA_values),length(HFA_InsideRatingFunction));
Colltotal=zeros(length(HFA_values),length(HFA_InsideRatingFunction));

%% Loop through each year to determine if ratings are inline with predictions
 for day=35:numofDays-1
%% Load matrices for old days and days+1
    [Games,Teams,~] = loadingMatrices(year,day);
    Games,Teams
    [Games,Teams]= modifyData(Games,Teams);  
    Games,Teams
    [NewGames,NewTeams,~] = loadingMatrices(year,day+1,day+1);
    NewGames,NewTeams
    i=0;
        for HFA = HFA_values
            i=i+1;
            j=0;
            for HFA_Inside = HFA_InsideRatingFunction
                j=j+1;
                colleyRatings = colleyRating(Games,Teams,HFA_Inside);

        %% Determine result of game
                 for elem = 1:size(NewGames,1)
                     
                    if Games(elem).winID==0||Games(elem).loseID==0
                        continue 
                    end
                     
                     NewLoc = NewGames(elem).Loc;

                    %Actual result of game 
                    actual_winner=NewGames(elem).winID;
                    actual_loser=NewGames(elem).loseID

                    % Get Colley ratings
                    collWin=colleyRatings(actual_winner)
                    collLos=colleyRatings(actual_loser)
                    %% HFA and add to accumulators   
                    if NewLoc==1
                        collWin=collWin+HFA;
                    elseif NewLoc==0
                        collWin=collWin-HFA;
                    end

                    if collWin>collLos
                        Coll_correct_pred(i,j)=Coll_correct_pred(i,j)+1;
                        Colltotal(i,j)=Colltotal(i,j)+1;
                    else
                        Colltotal(i,j)=Colltotal(i,j)+1;
                    end

                end
            end
        end
 end 
        
        

%% Calculate percentages!
 
percentCorrectColley= (Coll_correct_pred./Colltotal).*100

