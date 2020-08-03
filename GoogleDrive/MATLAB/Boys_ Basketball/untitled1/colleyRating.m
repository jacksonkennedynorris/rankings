function Colley = colleyRating(Games,Teams,HFA_Inside)
%% Colley's Equation
%Cr = b
    %The colley system uses the equation Cr = b. Using the Massey example, 
    %C = 2I + M. So we will formulate the Massey matrix and add in 2I. 
        %b is the rating, everyone starts at 1. 
nTeams = length(Teams);
M = zeros(nTeams,nTeams); %Initialize M with zeros
b = ones(nTeams,1);  
%Change this to mess with Colley point differentials
differential = 1/2;
%Calculate home and away differentials
h_differential = differential - HFA_Inside;
a_differential = differential + HFA_Inside;
for game = 1:length(Games)
    i = Games(game).winID; %i is the winner
    j = Games(game).loseID; %j is the loser
    
    pd = Games(game).PD;
    loc = Games(game).Loc;
    
    if i==0 || j==0  %Remove out of state games
        continue 
    end

    %%Change Diagonal Matrix%%
    M(i,i) = M(i,i) + 1; %Add one to the diagonal entries
    M(j,j) = M(j,j) + 1;
    M(i,j) = M(i,j) - 1; %Subtract one off the diagonal
    M(j,i) = M(j,i) - 1; 
    
    if loc == 1 % i at home
        i_change = h_differential;
        j_change = a_differential;
    elseif loc == 0 % j is home
        i_change = a_differential;
        j_change = h_differential;
    elseif loc == 2 % neutral site
        i_change = differential; 
        j_change = differential; 
    end
    if pd == 1/2 
        i_change = i_change/2; 
        j_change = j_change/2;
    end

    %Change b 
    b(i) = b(i) + i_change;
    b(j) = b(j) - j_change;
end
C = 2*eye(nTeams) + M;
r = inv(C)*b;
Colley = r;
% 
% function Colley = colleyRating(data,HFA_Inside)
% %%  Initialize our variables 
% Game = data.Game; 
% PD = data.PD; 
% Loc = data.Loc; 
% 
% diagMat= 2.*eye(length(Game(1,:))); %creates a matrix of diagonal 2s (We will change the 2s to add one for every game played
% WorL = ones(length(Game(1,:)),1); %This is the matrix we will fill with win or loss totals
% 
% %Commented out because looks like rewritten later 
% % differential = HFA_Inside; %Represents how much the win or loss matrix changes after a game
% % %  ** If we want to analyze Colley with point differential, we will change
% % %  the differential here (MAX of 1/2) **
% % 
% % h_differential = differential; %- HFA;
% % a_differential = differential; %+ HFA;
% 
% 
% %% Iterate through the Game Matrix 
% for elem = 1:length(Game)
%     K = find(Game(elem,:)); %Find who played (two number array)
%     if K
%         i = K(1); %i represents the first team that played
%         j = K(2); %j represents the second team that played
% 
%         %Store the value of win or loss (>0 is win, <0 is loss)
%         iWL = Game(elem,i);
%         
%         %Add one to the diagonal for each team that played
%         diagMat(i,i) = diagMat(i,i)+abs(iWL);
%         diagMat(j,j) = diagMat(j,j)+abs(iWL);
% 
%         %Subtract one to one of the diagonal for each team that played
%         diagMat(i,j) = diagMat(i,j)-abs(iWL); 
%         diagMat(j,i) = diagMat(j,i)-abs(iWL);
%         
%         differential = HFA_Inside * abs(iWL);
%         h_differential = (HFA_Inside) * abs(iWL);%- HFA) * abs(iWL);
%         a_differential = (HFA_Inside) * abs(iWL); %+ HFA) * abs(iWL);
%         if PD(elem) == 1/2 
%             h_differential = h_differential / 2;
%             a_differential = a_differential / 2; 
%             differential = differential / 2; 
%         end
%         if iWL > 0 && Loc(elem)==2 %i WINS at NEUTRAL
%             WorL(i) = WorL(i)+differential;
%             WorL(j) = WorL(j)-differential;
%         elseif iWL < 0 && Loc(elem)==2 %i LOSES at NEUTRAL
%             WorL(i) = WorL(i)-differential;
%             WorL(j) = WorL(j)+differential;
%         elseif iWL > 0 && Loc(elem)==1 %i WINS at home
%             WorL(i) = WorL(i)+h_differential;
%             WorL(j) = WorL(j)-h_differential;
%         elseif iWL < 0 && Loc(elem)==1 %i LOSES at home
%             WorL(i) = WorL(i)-a_differential;
%             WorL(j) = WorL(j)+a_differential;
%         elseif iWL > 0 && Loc(elem)==0 %i WINS away
%             WorL(i) = WorL(i)+a_differential;
%             WorL(j) = WorL(j)-a_differential;
%         elseif iWL < 0 && Loc(elem)==0 %i LOSES away
%             WorL(i) = WorL(i)-h_differential;
%             WorL(j) = WorL(j)+h_differential;  
%         end
%     end
% end
% 
% %% Final calculation
% Colley = inv(diagMat)*WorL; 