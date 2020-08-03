function [masseyNormal,colleyNormal,eloNormal,average_rating]=normalize_ratings(year)

%Find max and min for each rating system while loading all years 
%Also find median for all max/min ratings
%Equation for 100 to 0 scale (X-min)/(max-min) *100
%Apply formula to entire vector and normalize 
%Print to file function


sport = 'football';
year = num2str(year);

% load the raw ratings
masseyFile = strcat(sport,'/',year,'/ratings/masseyRating.txt');
colleyFile = strcat(sport,'/',year,'/ratings/colleyRating.txt');
eloFile = strcat(sport,'/',year,'/ratings/eloRating.txt');

Massey = load(masseyFile);
Colley = load(colleyFile); 
Elo = load(eloFile); 

% get parameters from get_historical_normalized_ratings.m (2013-2018)
median_min_mass = -64.7002;
median_max_mass = 56.3385;
median_min_coll = -0.0671;
median_max_coll = 1.1664;
median_min_elo = 1270.9;
median_max_elo = 1825.3;

% normalize ratings
masseyNormal=(Massey-median_min_mass)./(median_max_mass-median_min_mass).*100;
colleyNormal=(Colley-median_min_coll)./(median_max_coll-median_min_coll).*100;
eloNormal=(Elo-median_min_elo)./(median_max_elo-median_min_elo).*100;

% average the normalized ratings
average_rating=mean([masseyNormal';colleyNormal';eloNormal'])';

% save the ratings to file
folderName = strcat(sport, '/',year,'/ratings/');
cd(folderName)       
save('normalizedEloRating.txt','eloNormal','-ascii')
save('normalizedColleyRating.txt','colleyNormal','-ascii')
save('normalizedMasseyRating.txt','masseyNormal','-ascii')
save('averageRating.txt','average_rating','-ascii')
cd ../../..
        
    
end