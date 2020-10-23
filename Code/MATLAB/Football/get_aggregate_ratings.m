function [average_rating]=get_aggregate_ratings(year)
%Find max and min for each rating system while loading all years 
%Also find median for all max/min ratings
%Equation for 100 to 0 scale (X-min)/(max-min) *100
%Apply formula to entire vector and normalize 
%Print to file function
yearm1 = year-1;
year = num2str(year);
yearm1 = num2str(yearm1);
yearStr = strcat(yearm1,'-',year);
year = yearStr;

prev_years = [year-5:year-1];
syear = str(year);

% load the raw ratings
masseyFile = strcat(syear,'/rankings/masseyRating.txt');
colleyFile = strcat(year,'/rankings/colleyRating.txt');
eloFile = strcat(year,'/rankings/eloRating.txt');

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
folderName = strcat(year,'/ratings/');
cd(folderName)       
save('normalizedEloRating.txt','eloNormal','-ascii')
save('normalizedColleyRating.txt','colleyNormal','-ascii')
save('normalizedMasseyRating.txt','masseyNormal','-ascii')
save('averageRating.txt','average_rating','-ascii')
cd ../..
    
end
'/ratings/masseyRating.txt');
colleyFile = strcat(year,'/ratings/colleyRating.txt');
eloFile = strcat(year,'/ratings/eloRating.txt');

Massey = load(masseyFile);
Colley = load(colleyFile); 
Elo = load(eloFile); 

% get parameters from get_historical_normalized_ratings.m (2013-2018)
% median_min_mass = -64.7002;
% median_max_mass = 56.3385;
% median_min_coll = -0.0671;
% median_max_coll = 1.1664;
% median_min_elo = 1270.9;
% median_max_elo = 1825.3;

% normalize ratings
masseyNormal=(Massey-median_min_mass)./(median_max_mass-median_min_mass).*100;
colleyNormal=(Colley-median_min_coll)./(median_max_coll-median_min_coll).*100;
eloNormal=(Elo-median_min_elo)./(median_max_elo-median_min_elo).*100;

% average the normalized ratings
average_rating=mean([masseyNormal';colleyNormal';eloNormal'])';

% save the ratings to file
folderName = strcat(year,'/ratings/');
cd(folderName)       
save('normalizedEloRating.txt','eloNormal','-ascii')
save('normalizedColleyRating.txt','colleyNormal','-ascii')
save('normalizedMasseyRating.txt','masseyNormal','-ascii')
save('averageRating.txt','average_rating','-ascii')
cd ../..
    
end
