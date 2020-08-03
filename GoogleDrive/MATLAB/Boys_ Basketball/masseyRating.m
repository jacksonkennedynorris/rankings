function [Massey,offense,defense] = masseyRating(Games,Teams)
%% Massey's Equation
% Mr = p 
        %Mii represents the number of games played by team i 
        %Mij (i~=j) represents the -number of games team i played against team j. 
    %p is the point-differential column vector 
    %r is the ratings     
nTeams = length(Teams);
M = zeros(nTeams,nTeams); %Initialize M with zeros
pd = zeros(nTeams,1);  
%p_for represents the points for and p_against represents points against 
p_for = zeros(nTeams,1); 
p_against = zeros(nTeams,1); 
for game = 1:length(Games)
    i = Games(game).winID; %i is the winner
    j = Games(game).loseID; %j is the loser

    %Find points of winner and loser
    points_winner = Games(game).winScore; 
    points_loser = Games(game).loseScore;
    
    point_differential = Games(game).PD;
    if i==0 || j==0  %Remove out of state games
        continue 
    end
    %%Change Diagonal Matrix%%
    M(i,i) = M(i,i) + 1; %Add one to the diagonal entries
    M(j,j) = M(j,j) + 1;
    M(i,j) = M(i,j) - 1; %Subtract one off the diagonal
    M(j,i) = M(j,i) - 1; 
    %%Change Point Differential Matrix
    pd(i) = pd(i) + point_differential;
    pd(j) = pd(j) - point_differential;
    
    %Calculate points for and against
    p_for(i) = p_for(i) + points_winner;
    p_for(j) = p_for(j) + points_loser;
    p_against(i) = p_against(i) + points_loser;
    p_against(j) = p_against(j) + points_winner;
    
end
%Split into diagonal and off-diagonal entries. (Used for offense and defense)
T = diag(diag(M)); %% Amazingly, gets rid of off diagonal entries. 
P = T - M;

%M is not invertible. We must make some changes. 
    %Add a row of ones to the nth element. Then add a zero to the nth
    %element of the PD. 
M(end,:) = ones(1, nTeams);
pd(end) = 0; 
r = inv(M)*pd;
Massey = r; 

%% Create point spread 
%(T+P)*d = T*r - f;
defense = inv(T+P)* (T*r - p_for); 
offense = r - defense; %Offense(i) represents number of points team i is expected 
                        %to score against average opponent