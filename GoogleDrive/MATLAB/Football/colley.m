function Colley = colley(Games,Teams,HFA_Inside)
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
 
    if i==0 || j==0  %Remove out of state games
        continue 
    end
    loc = 2;
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