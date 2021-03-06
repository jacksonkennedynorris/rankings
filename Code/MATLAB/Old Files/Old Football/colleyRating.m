function Colley = colleyRating(Game,PD,Loc,HFA)
%%  Initialize our variables 

numGames = size(Game,2); %Finds the teams who played games 
diagMat= 2.*eye(numGames); %creates a matrix of diagonal 2s (We will change the 2s to add one for every game played
WorL = ones(numGames,1); %This is the matrix we will fill with win or loss totals


differential = 1/2; %Represents how much the win or loss matrix changes after a game
%  ** If we want to analyze Colley with point differential, we will change
%  the differential here (MAX of 1/2) **

h_differential = differential - HFA;
a_differential = differential + HFA;


%% Iterate through the Game Matrix 
for elem = 1:length(Game)
    K = find(Game(elem,:)); %Find who played (two number array)
    if K

        i = K(1); %i represents the first team that played
        j = K(2); %j represents the second team that played

        %Store the value of win or loss (>0 is win, <0 is loss)
        iWL = Game(elem,i);
        
        %Add one to the diagonal for each team that played
        diagMat(i,i) = diagMat(i,i)+abs(iWL);
        diagMat(j,j) = diagMat(j,j)+abs(iWL);

        %Subtract one to one of the diagonal for each team that played
        diagMat(i,j) = diagMat(i,j)-abs(iWL); 
        diagMat(j,i) = diagMat(j,i)-abs(iWL);
        
        differential = .5 * abs(iWL);
        h_differential = (.5 - HFA) * abs(iWL);
        a_differential = (.5 + HFA) * abs(iWL);
        if PD(elem) == 1/2 
            h_differential = h_differential / 2;
            a_differential = a_differential / 2; 
            differential = differential / 2; 
        end
        if iWL > 0 && Loc(elem)==2 %i WINS at NEUTRAL
            WorL(i) = WorL(i)+differential;
            WorL(j) = WorL(j)-differential;
        elseif iWL < 0 && Loc(elem)==2 %i LOSES at NEUTRAL
            WorL(i) = WorL(i)-differential;
            WorL(j) = WorL(j)+differential;
        elseif iWL > 0 && Loc(elem)==1 %i WINS at home
            WorL(i) = WorL(i)+h_differential;
            WorL(j) = WorL(j)-h_differential;
        elseif iWL < 0 && Loc(elem)==1 %i LOSES at home
            WorL(i) = WorL(i)-a_differential;
            WorL(j) = WorL(j)+a_differential;
        elseif iWL > 0 && Loc(elem)==0 %i WINS away
            WorL(i) = WorL(i)+a_differential;
            WorL(j) = WorL(j)-a_differential;
        elseif iWL < 0 && Loc(elem)==0 %i LOSES away
            WorL(i) = WorL(i)-h_differential;
            WorL(j) = WorL(j)+h_differential;  
        end
    end
end

%% Final calculation
Colley = inv(diagMat)*WorL; 


