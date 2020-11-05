function [Elo,save_data] = eloRatingInWork(Game,PD,Loc,initElo,HFA,Name,year,s,k)
%% Initialize the elo rating for every team at start of season

%% Initialize our parameters
% k=32; %ANALYZE THIS NUMBER
% s=400; %this represents a 400 point advantage 

%400 point advantage means team A is 10x better than team B

%%%% TAKE OUT LATER
% probs of winner 
probs = zeros(length(Game)-600,1);
%%%% END TAKE OUT 

save_data = [];
count = 0;
numGames = length(Game) - 600;
%% Iterate through game matrix 

% for s = 200:10:400
%     for k = 20:4:60
%         for HFA = 10:2:40
            R = initElo;
            myLength = length(Name);
%             if year == "2012"
%                 R = ones(myLength,1)*1500;
%             end
            count = 0;
            for elem=1:length(Game)
                findGame = find(Game(elem,:));
%                 if findGame(1) == 173 || findGame(2) == 173
%                     
%                     disp("POWELL")
%                     R(173)
%                 end
%                 if findGame(1) == 49 || findGame(2) == 49
%                     disp("CORBIN")
%                     R(49)
%                     
%                 end
                if findGame
                    i = findGame(1); % Find teams that play
                    j = findGame(2);
                    Ri = R(i); % Find ratings of that team
                    Rj = R(j);

                    iWL = Game(elem,i); % Find whether the team won or lost
                    jWL = Game(elem,j);

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
%                     predictJ = 1/(1+10^((Ri-(Rj-HFAi))/s))

                    %%% GET PROBS OF WINNERs %%%%%%
                    if elem > 600
%                         Name(i)
%                         Name(j)
%                         predictI
%                         PD(elem)
%                         Loc(elem) 
%                         iWL
%                         Ri
%                         Rj
                        if iWL == 1 
                            probs(elem-600) = predictI;
                            if predictI >.5 
                                count = count + 1;
                            end
                        else
                            if predictJ >.5 
                                count = count + 1;
                            end
                            probs(elem-600) = predictJ;
                        end
                    end

                    %Update the ratings
                    R(i) = R(i) + k*(iWL-predictI);
                    R(j) = R(j) + k*(jWL-predictJ);
                    
                end
            end
           log_like = sum(log(probs));
           percent = (count/numGames)*100;
           save_data = [save_data; s k HFA log_like percent];
 
Elo = R;

