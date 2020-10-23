function Colley = colleyMethod(Game,PD,Loc)
%%  Initialize our variables 

numGames = size(Game,2); %Finds the teams who played games 
diagMat= 2.*eye(numGames); %creates a matrix of diagonal 2s (We will change the 2s to add one for every game played
WorL = ones(numGames,1); %This is the matrix we will fill with win or loss totals


differential = 1/2; %Represents how much the win or loss matrix changes after a game
%  ** If we want to analyze Colley with point differential, we will change
%  the differential here (MAX of 1/2) **

%% Iterate through the Game Matrix 
for elem = 1:length(Game)
    K = find(Game(elem,:)); %Find who played (two number array)
    i = K(1); %i represents the first team that played
    j = K(2); %j represents the second team that played
    
    %Add one to the diagonal for each team that played
    diagMat(i,i) = diagMat(i,i)+1;
    diagMat(j,j) = diagMat(j,j)+1;
    
    %Subtract one to one of the diagonal for each team that played
    diagMat(i,j) = diagMat(i,j)-1; 
    diagMat(j,i) = diagMat(j,i)-1;
    
    %Store the value of win or loss (1 is win, -1 is loss)
    iWL = Game(elem,i);
    jWL = Game(elem,j);
    
    if iWL == 1 %i WINS
        WorL(i) = WorL(i)+differential;
        WorL(j) = WorL(j)-differential;
    else %i LOSES
        WorL(i) = WorL(i)-differential;
        WorL(j) = WorL(j)+differential;
    end
end
%% Final calculation
Colley = inv(diagMat)*WorL; 


