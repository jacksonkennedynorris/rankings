function Elo = elo(Games,Teams,year,sport,k,s,HFA)
%% Initialize our parameters
k=35; %ANALYZE THIS NUMBER
s=220; %this represents a 400 point advantage 
HFA = 11;
%400 point advantage means team A is 10x better than team B
[Games, R] = initialElo(Games,Teams,year,sport);
%R = 1500*ones(1,length(Teams));
%%%% TAKE OUT LATER
% probs of winner 
%probs = zeros(length(Game)-600,1);
%%%% END TAKE OUT 
%% Iterate through game matrix 
for game= 1:length(Games)

    i = Games(game).win_id; 
    j = Games(game).lose_id; 
%     i = find([Teams.name]' == winner);
%     j = find([Teams.name]' == loser);

    pd = Games(game).win_score - Games(game).lose_score;
    loc = Games(game).location;
    
    if Games(game).cross_region ~= 0 
        Games(game).elo_diff = R(i) - R(j);
    end
    
   
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

Elo = R;

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