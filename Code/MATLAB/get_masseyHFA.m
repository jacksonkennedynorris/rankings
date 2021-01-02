function[percentCorrectMassey]=get_masseyHFA(year)

%Test the ratings
%% Accumulators

%numofDays = 92; %rather than the day
sport = "Football";
%code to open up file for sport?

%Values added to a win or loss later in this code
%HFA_values = 0.002:0.001:0.02; %0.02:0.002:0.05;
%Used inside the colley function
HFA_InsideRatingFunction = 2.1:0.05:2.5; %0.03:0.01:0.1;

%Create empty vectors for loop
Mass_correct_pred=zeros(length(HFA_InsideRatingFunction),1);
Masstotal=zeros(length(HFA_InsideRatingFunction),1);

%% Loop through each year to determine if ratings are inline with predictions
%Use struct to split new games and old games
[Games, Teams, saveFinal] = loadingMatrices(year);
oldGames=Games(1:800);
NewGames=Games(801:length(Games));

j=0;
for HFA = HFA_InsideRatingFunction %rows
    j=j+1;
    masseyRatings = massey(oldGames,Teams,HFA);
  

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
        massWin=masseyRatings(actual_winner);
        massLos=masseyRatings(actual_loser);
        %% HFA and add to accumulators
        if NewLoc==1 %1 is home 
            massWin=massWin+HFA;
        elseif NewLoc==0
            massWin=massWin-HFA;
        end
      
        if massWin>massLos
            Mass_correct_pred(j)=Mass_correct_pred(j)+1;
            Masstotal(j)=Masstotal(j)+1;
        else
            Masstotal(j)=Masstotal(j)+1;
        end

    end
end



%% Calculate percentages!

percentCorrectMassey= (Mass_correct_pred./Masstotal).*100;