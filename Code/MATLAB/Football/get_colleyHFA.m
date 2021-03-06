function [percentCorrectColley] = get_colleyHFA(year)
%Test the ratings
%% Accumulators

%numofDays = 92; %rather than the day
sport = "Football";
%code to open up file for sport?


%Values added to a win or loss later in this code
HFA_values = 0.002:0.001:0.02; %0.02:0.002:0.05;
%Used inside the colley function
HFA_InsideRatingFunction = 0.02:0.05:0.035; %0.03:0.01:0.1;

%Create empty vectors for loop
Coll_correct_pred=zeros(length(HFA_values),length(HFA_InsideRatingFunction));
Colltotal=zeros(length(HFA_values),length(HFA_InsideRatingFunction));

%% Loop through each year to determine if ratings are inline with predictions
%Use struct to split new games and old games
[Games, Teams, saveFinal] = loadingMatrices(year);
oldGames=Games(1:800);
NewGames=Games(801:length(Games));

i=0;
for HFA = HFA_values %columns
    i=i+1;
    j=0;
    for HFA_Inside = HFA_InsideRatingFunction %rows
        j=j+1;
        colleyRatings = colley(oldGames,Teams,HFA_Inside);

%% Determine result of game
         for elem = 1:length(NewGames)

            if NewGames(elem).winID==0||NewGames(elem).loseID==0
                continue
            end

             NewLoc = NewGames(elem).Loc;

            %Actual result of game
            actual_winner=NewGames(elem).winID;
            actual_loser=NewGames(elem).loseID;

            % Get Colley ratings
            collWin=colleyRatings(actual_winner);
            collLos=colleyRatings(actual_loser);
            %% HFA and add to accumulators
            if NewLoc==1 %1 is home 
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



%% Calculate percentages!

percentCorrectColley= (Coll_correct_pred./Colltotal).*100
