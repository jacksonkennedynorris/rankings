function Massey = massey(Games,Teams,HFA)
%% Massey Ratings
% M(i,j) = 1 if team j won game i; = -1 if team j lost game i
% M is n x k, where n = # games, k = # teams
% pd = n x 1 vector of point differentials

nGames = length(Games);
nTeams = length(Teams);
M = zeros(nGames,nTeams); %Initialize M with zeros
pd = zeros(nGames,1);  

for game = 1:length(Games)
    i = Games(game).winID; %i is the winner
    j = Games(game).loseID; %j is the loser

    if i==0 || j==0  %Remove out of state games
        continue 
    end
    
    %Find points of winner and loser
    points_winner = Games(game).winScore; 
    points_loser = Games(game).loseScore;
    
    point_differential = Games(game).PD;
    loc = Games(game).Loc;
    
    %%Change Game Matrix%%
    M(game,i) = M(game,i) + 1; %Add one to the winner entry
    M(game,j) = M(game,j) - 1; %Subtract one from the loser entry
    
    %%Change Point Differential Vector
    if loc == 1 % i won at home
        pd(game) = point_differential - HFA;
    elseif loc == 0 % i won on road
        pd(game) = point_differential + HFA;
    elseif loc == 2 % neutral site
        pd(game) = point_differential;
    end
end

% Calculate Massey ratings
Massey = inv(M'*M)*M'*pd; 
