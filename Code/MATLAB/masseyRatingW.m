function Massey = masseyRatingW(Games,Teams,hfa,sport)
%%%%% masseyRatingW includes WEIGHTS
%% Initialize Variables
Massey = massey(Games,Teams,hfa) 

oldMassey=zeros(length(Massey),1);
hfa = 2;
while norm(Massey-oldMassey) > 0.0001
    
    trial = get_massey_prediction(Games,Teams,hfa,Massey)
    
    weights = calc_massey_weights(predMargin,PD);
    
    weightedGame=weights.*Game;
    weightedPD=weights.*PD;
    weightedGame = [weightedGame; ones(1,len)]; %Add ones to the last row in the game matrix
    weightedPD = [weightedPD; 0];
    M_adj=weightedGame'*weightedGame;
    
    oldMassey=Massey;
    Massey=inv(M_adj)*weightedGame'*weightedPD;
   
end
% [newData,Games,Teams] = createGameMat(Games,Teams);
% Game= newData.Game;
% PD= newData.PD;
% Loc= newdata.Loc;
% 
% pointGap = 35; %This is the max number that a team can win by 
% %% Iterate through game loop
% %Took out all the elems 
% for elem = 1:length(PD) %This loop eliminates the huge point gap and codifies HFA
% 
%     if PD(elem) >= pointGap
%         PD(elem) = pointGap;
%     end
%     %elem
%     %length(Loc)
%     %Loc(elem)
%     if Loc(elem) == 1 %Home team wins
%         if PD(elem) < hfa
%             PD = PD(elem) - hfa;%htw;
%         end
%     elseif Loc(elem) == 0 %Home team loses 
%         PD = PD(elem) + hfa;
%     elseif Loc(elem) == 2 %Neutral location (no hfa) 
%         PD = PD(elem);
%     end
% end 
% 
% %% Make final calculations
% len = size(Game,2); %Find number of teams
% Game = [Game; ones(1,len)]; %Add ones to the last row in the game matrix
% PD = [PD; 0]; %Add a zero to the last column in the game matrix
% M = Game'*Game; %Multiply the inverse of the game time the Game (document calls this M)
% Massey = inv(M)*Game'*PD;
% Game(end,:)=[]; PD(end)=[];
