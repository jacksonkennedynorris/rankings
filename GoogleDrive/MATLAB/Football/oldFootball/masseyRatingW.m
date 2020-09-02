function Massey = masseyRatingW(Game,PD,Loc,hfa)
%%%%% masseyRatingW includes WEIGHTS
%% Initialize Variables
htw = 1; %If the home team wins by less than the home field advantage, the 
         %winning team will still "win" by tis amount (ANALYZE/THINK ABOUT)
pointGap = 35; %This is the max number that a team can win by 
%% Iterate through game loop
for elem = 1:length(PD) %This loop eliminates the huge point gap and codifies HFA
    if PD(elem) >= pointGap
        PD(elem) = pointGap;
    end
    %elem
    %length(Loc)
    %Loc(elem)
    if Loc(elem) == 1 %Home team wins
        if PD(elem) < hfa
            PD(elem) = PD(elem) - hfa;%htw;
        elseif PD(elem) >= 3
            PD(elem) = PD(elem) - hfa;
        end
    elseif Loc(elem) == 0 %Home team loses 
        PD(elem) = PD(elem) + hfa;
    elseif Loc(elem) == 2 %Neutral location (no hfa) 
        PD(elem) = PD(elem);
    end
end 

%% Make final calculations
l = length(Game(:,1));
%length(PD) 
%length(Loc)

len = size(Game,2); %Find number of teams
Game = [Game; ones(1,len)]; %Add ones to the last row in the game matrix
PD = [PD; 0]; %Add a zero to the last column in the game matrix
M = Game'*Game; %Multiply the inverse of the game time the Game (document calls this M)
Massey = inv(M)*Game'*PD;
Game(end,:)=[]; PD(end)=[];
oldMassey=zeros(length(Massey),1);

while norm(Massey-oldMassey) > 0.0001
    
    predMargin = get_massey_prediction(Game,Massey,Loc);

    weights = calc_massey_weights(predMargin,PD);

    weightedGame=weights.*Game;
    weightedPD=weights.*PD;
    weightedGame = [weightedGame; ones(1,len)]; %Add ones to the last row in the game matrix
    weightedPD = [weightedPD; 0];
    M_adj=weightedGame'*weightedGame;
    
    oldMassey=Massey;
    Massey=inv(M_adj)*weightedGame'*weightedPD;
   
end

