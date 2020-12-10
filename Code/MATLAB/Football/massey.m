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
    winner = Games(game).win_team;
    loser = Games(game).lose_team;
    
    i = find([Teams.name]' == winner);
    j = find([Teams.name]' == loser);
    if Games(game).overtime 
       point_differential = 1/2; 
    else
        point_differential = Games(game).win_score - Games(game).lose_score;
        if point_differential >= 36 
           point_differential = 36;
        end
    end
    loc = Games(game).location;
    
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
M = [M; ones(1,nTeams)];
pd = [pd; 0];
Massey = inv(M'*M)*M'*pd;
