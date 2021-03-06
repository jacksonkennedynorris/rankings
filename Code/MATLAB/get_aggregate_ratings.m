function [average_rating, Teams]=get_aggregate_ratings(Teams, year,sport)
%Find max and min for each rating system while loading all years 
%Also find median for all max/min ratings
%Equation for 100 to 0 scale (X-min)/(max-min) *100
%Apply formula to entire vector and normalize 
%Print to file function
% load the raw ratings

masseyFile = strcat(sport + "/Data/" + num2str(year) + "/Ratings/masseyRating.txt");
colleyFile = strcat(sport + "/Data/" + num2str(year) + "/Ratings/colleyRating.txt");
eloFile = strcat(sport + "/Data/" + num2str(year) + "/Ratings/eloRating.txt");

Massey = readtable(masseyFile); 
Massey = Massey{:,2}; 
Colley = readtable(colleyFile); 
Colley = Colley{:,2}; 
Elo = readtable(eloFile); 
Elo = Elo{:,2};
if sport == "Football" 
    % get parameters from get_historical_normalized_ratings.m (2013-2018)
    median_min_mass = -53.9125;
    median_max_mass = 52.4871;
    median_min_coll = -.0297;
    median_max_coll = 1.1013;
    median_min_elo = 1.312e+03;
    median_max_elo = 1.7795e+03;
elseif sport == "Boys Basketball" 
   median_min_mass = -49.4815;
   median_min_coll = -.02277;
   median_min_elo = 1.1898e+03;
   median_max_mass = 34.8441;
   median_max_coll =  1.1646; 
   median_max_elo = 1.8831e+03;
end
% normalize ratings
masseyNormal=(Massey-median_min_mass)./(median_max_mass-median_min_mass).*100;
colleyNormal=(Colley-median_min_coll)./(median_max_coll-median_min_coll).*100;
eloNormal=(Elo-median_min_elo)./(median_max_elo-median_min_elo).*100;

% average the normalized ratings
average_rating=mean([masseyNormal';colleyNormal';eloNormal'])';

% save the ratings to file
elo_file = sport + "/Data/" + num2str(year) + "/Ratings/normalizedEloRating.txt"; 
mass_file = sport + "/Data/" + num2str(year) + "/Ratings/normalizedMasseyRating.txt";
coll_file = sport + "/Data/" + num2str(year) + "/Ratings/normalizedColleyRating.txt";
save(elo_file,'eloNormal','-ascii')
save(coll_file,'colleyNormal','-ascii')
save(mass_file,'masseyNormal','-ascii')
save(sport + "/Data/" + num2str(year) + "/Ratings/averageRating.txt",'average_rating','-ascii')

%[~,i] = sort(average_rating, 'descend');
%Sort 
% masseyNormal = masseyNormal(i);
% colleyNormal = colleyNormal(i); 
% eloNormal = eloNormal(i); 

for team = 1:length(Teams)
    Teams(team).rating = round(average_rating(team),2); 
    Teams(team).massey = round(masseyNormal(team),2); 
    Teams(team).colley = round(colleyNormal(team),2); 
    Teams(team).elo = round(eloNormal(team),2); 
end
