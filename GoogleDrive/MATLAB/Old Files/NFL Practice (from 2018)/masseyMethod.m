function Massey = masseyMethod(Game,PD,Loc)
%% Initialize Variables
hfa = 3; %Constant representing the home field advantage
htw = 1; %If the home team wins by less than the home field advantage, the 
         %winning team will still "win" by this amount (ANALYZE)
pointGap = 21; %This is the max number that a team can win by 

%% Iterate through game loop
for elem = 1:length(PD) %This loop eliminates the huge point gap and codifies HFA
    if PD(elem) >= pointGap
        PD(elem) = pointGap;
    end
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

len = size(Game,2); %Find number of teams
Game = [Game; ones(1,len)]; %Add ones to the last row in the game matrix
PD = [PD; 0]; %Add a zero to the last column in the game matrix
M = Game'*Game; %Multiply the inverse of the game time the Game (document calls this M)

%%FINAL CALCULATION%%
Massey=inv(M)*Game'*PD; 
