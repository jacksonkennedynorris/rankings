function Elo = eloRating(game)
Game = game.Game; 
PD = game.PD;
Loc = game.Loc; 
%% Initialize the elo rating for every team at start of season
%For now initializing every team to 1500
initElo=ones(size(Game,2),1)*1500;
R = initElo;
%% Initialize our parameters
k=35; %ANALYZE THIS NUMBER
s=220; %this represents a 400 point advantage 
HFA = 11;
%400 point advantage means team A is 10x better than team B

%%%% TAKE OUT LATER
% probs of winner 
%probs = zeros(length(Game)-600,1);
%%%% END TAKE OUT 


%% Iterate through game matrix 
for elem=1:length(Game)
    findGame = find(Game(elem,:));
    if findGame
        firstTeam = findGame(1); % Find teams that play
        secondTeam = findGame(2);
        R1 = R(firstTeam); % Find ratings of that team
        R2 = R(secondTeam);

        iWL = Game(elem,firstTeam); % Find whether the team won or lost
        jWL = Game(elem,secondTeam);

        if iWL == 1 %I WINS
            iWL = 1;
            jWL = 0;
        else %I LOSES
            iWL = 0;
            jWL = 1;
        end
%% Figure out HFA 
        if Loc(elem) == 1 && iWL == 1%i is at home and wins
            HFAi = HFA;
            HFAj = 0; 
        elseif Loc(elem) == 0 && iWL == 0 %i is at home and loses
            HFAi = HFA;
            HFAj = 0;
        elseif Loc(elem) == 0 && iWL == 1 %i is away and wins 
            HFAi = 0; 
            HFAj = HFA;
        elseif Loc(elem) == 1 && iWL == 0 %i is away and loses
            HFAi = 0; 
            HFAj = HFA;
        elseif Loc(elem) == 2 
            HFAi = 0; 
            HFAj = 0; 
        end
%% Calculate Ratings             
        %Calculate the predictions
        predictI = 1/(1+10^((R2-R1+HFAi)/s));
        predictJ = 1/(1+10^((R1-R1+HFAj)/s));

        %%% GET PROBS OF WINNERs %%%%%%
%         if elem > 600
%             prob(elem) = predictIorJ

        %Update the ratings
        if PD(elem) == 1/2 
            R(firstTeam) = R(firstTeam) + k*(iWL-predictI);
            R(secondTeam) = R(secondTeam) + k*(jWL-predictJ);
%             R(firstTeam) = R(firstTeam) + (1/2)*k*(iWL-predictI);
%             R(secondTeam) = R(secondTeam) + (1/2)*k*(jWL-predictJ);
        else
            R(firstTeam) = R(firstTeam) + k*(iWL-predictI);
            R(secondTeam) = R(secondTeam) + k*(jWL-predictJ);
        end
    end
end
Elo = R;
%%% MORE EXTRA STUFF
% log_like = sum(log(probs))
% save_data = [save_data; s k HFA log_like];