function Elo = elo(Games,Teams,year,k,s,HFA)
%% Initialize our parameters
k=35; %ANALYZE THIS NUMBER
s=220; %this represents a 400 point advantage 
HFA = 11;
%400 point advantage means team A is 10x better than team B
R = initialElo(Games,Teams,year);
%%%% TAKE OUT LATER
% probs of winner 
%probs = zeros(length(Game)-600,1);
%%%% END TAKE OUT 
%% Iterate through game matrix 
for game=1:length(Games)
    
    i = Games(game).winID; %winner 
    j = Games(game).loseID; 
    if i == 0 || j == 0 %Remove out of state
        continue 
    end
    pd = Games(game).PD;
    loc = Games(game).Loc;
    if loc == 1 %winner is at home
        HFAi = HFA;
        HFAj = 0; 
    elseif loc == 0 %winner is away
        HFAi = 0; 
        HFAj = HFA;
    elseif loc == 2
        HFAi = 0;
        HFAj = 0;
    end
%% Calculate Ratings             
        %Calculate the predictions
        predictI = 1/(1+10^((R(j)-R(i)+HFAi)/s));
        predictJ = 1/(1+10^((R(i)-R(j)+HFAj)/s));

        %Update the ratings
        if pd == 1/2 
%             R(i) = R(i) + k*(1-predictI);
%             R(j) = R(j) + k*(0-predictJ);
            R(i) = R(i) + (1/2)*k*(1-predictI);
            R(j) = R(j) + (1/2)*k*(0-predictJ);
        else
            R(i) = R(i) + k*(1-predictI);
            R(j) = R(j) + k*(0-predictJ);
        end

end

Elo = R';

%%% MORE EXTRA STUFF
% log_like = sum(log(probs))
% save_data = [save_data; s k HFA log_like];


%     %% Figure out HFA 
%         if Loc(elem) == 1 && iWL == 1%i is at home and wins
%             HFAi = HFA;
%             HFAj = 0; 
%         elseif Loc(elem) == 0 && iWL == 0 %i is at home and loses
%             HFAi = HFA;
%             HFAj = 0;
%         elseif Loc(elem) == 0 && iWL == 1 %i is away and wins 
%             HFAi = 0; 
%             HFAj = HFA;
%         elseif Loc(elem) == 1 && iWL == 0 %i is away and loses
%             HFAi = 0; 
%             HFAj = HFA;
%         elseif Loc(elem) == 2 
%             HFAi = 0; 
%             HFAj = 0; 
%         end