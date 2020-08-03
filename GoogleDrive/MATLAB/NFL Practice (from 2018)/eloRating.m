function [Elo,save_data] = eloRating(Game,PD,Loc)
%% Initialize the elo rating for every team at start of season

R = ones(32,1)*1500;
%% Initialize our parameters
k=32; %ANALYZE THIS NUMBER
s=400; %this represents a 400 point advantage 
HFA = 0;
%400 point advantage means team A is 10x better than team B

%%%% TAKE OUT LATER
% probs of winner 
length(Game)
probs = ones(length(Game)-30,1);
probs = probs * 2; 

%%%% END TAKE OUT 

save_data = [];
numGames = length(Game) - 30;
%% Iterate through game matrix 

for s = 400
    for k = 32
        for HFA = 0
            R = ones(32,1)*1500;
            count = 0;
            for elem=1:length(Game)
                findGame = find(Game(elem,:));
                if findGame
                    firstTeam = findGame(1); % Find teams that play
                    secondTeam = findGame(2);
                    Ri = R(firstTeam); % Find ratings of that team
                    Rj = R(secondTeam);

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
                    elseif Loc(elem) == 0 && iWL == 0 %i is at home and loses
                        HFAi = HFA;
                    elseif Loc(elem) == 0 && iWL == 1 %i is away and wins 
                        HFAi = -HFA;
                    elseif Loc(elem) == 1 && iWL == 0 %i is away and loses
                        HFAi = -HFA;
                    elseif Loc(elem) == 2 
                        HFAi = 0; 
                    end
            %% Calculate Ratings             
                    %Calculate the predictions
                    predictI = 1/(1+10^((Rj-(Ri+HFAi))/s));
                    predictJ = 1-predictI;

                    %%% GET PROBS OF WINNERs %%%%%%
                    if elem > 30
                        if iWL == 1 
                            probs(elem-30) = predictI;
                            if predictI >.5 
                                count = count + 1;
                            end
                        else
                            probs(elem-30) = predictJ;
                            if predictJ >.5 
                                count = count + 1;
                            end
                        end
                    end

                    %Update the ratings
                    R(firstTeam) = R(firstTeam) + k*(iWL-predictI);
                    R(secondTeam) = R(secondTeam) + k*(jWL-predictJ);
                end
            end
           log_like = sum(log(probs));
           percent = (count/numGames)*100;
           save_data = [save_data; s k HFA log_like percent];
        end
    end
end
Elo = R;

save_data




% 
% %% Initialize the elo rating for every team at start of season
% R = [];
% for elem =1:length(Game(1,:))
%     R(elem) = 1500;
% end
% R=R'; %Transpose to be columns
% %% Initialize our parameters
% k=32; %ANALYZE THIS NUMBER
% s=400; %this represents a 400 point advantage 
% %400 point advantage means team A is 10x better than team B
% 
% %ADJUST HOME FIELD ADVANTAGE
% HFA = 0;
% 
% %% Iterate through game matrix 
% for elem=1:length(Game)
%     K = find(Game(elem,:));
%     i = K(1);
%     j = K(2);
%     R1 = R(i);
%     R2 = R(j);
%     iWL = Game(elem,i);
%     jWL = Game(elem,j);
%     if iWL == 1 %I WINS
%         iWL = 1;
%         jWL = 0;
%     else %I LOSES
%         iWL = 0;
%         jWL = 1;
%     end
%     predictI = 1/(1+10^((R2-R1-HFA)/s));
%     predictJ = 1/(1+10^((R1-R1-HFA)/s));
%     R(i) = R(i) + k*(iWL-predictI);
%     R(j) = R(j) + k*(jWL-predictJ);
% end
% Elo = R;
