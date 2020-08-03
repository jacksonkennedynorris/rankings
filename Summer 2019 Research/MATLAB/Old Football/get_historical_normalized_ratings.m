function [masseyNormal,colleyNormal,eloNormal,average_rating]=get_historical_normalized_ratings(years)

%Find max and min for each rating system while loading all years 
%Also find median for all max/min ratings
%Equation for 100 to 0 scale (X-min)/(max-min) *100
%Apply formula to entire vector and normalize 
%Print to file function

%% Accumulators
sport='Football';
maxMassey=zeros(length(years),1);
minMassey=zeros(length(years),1);
maxColley=zeros(length(years),1);
minColley=zeros(length(years),1);
maxElo=zeros(length(years),1);
minElo=zeros(length(years),1);
i=0;
%% Load ratings and create max/min vectors
for year = years
    year = num2str(year);
    i=i+1;
    [Massey,Colley,Elo,~]=loadingRatings(year,sport);
%% Massey    
    maxMassey(i)=max(Massey);
    minMassey(i)=min(Massey);
%% Colley
    maxColley(i)=max(Colley);
    minColley(i)=min(Colley);
%% Elo
    maxElo(i)=max(Elo);
    minElo(i)=min(Elo);
end
%% Median values
median_max_mass=median(maxMassey)
median_min_mass=median(minMassey)

median_max_coll=median(maxColley)
median_min_coll=median(minColley)

median_max_elo=median(maxElo)
median_min_elo=median(minElo)

%% Normalize each year and print to file 
for year = years
    year = num2str(year);
    
    [Massey,Colley,Elo,~]=loadingRatings(year,sport);
    
    masseyNormal=(Massey-median_min_mass)./(median_max_mass...
        -median_min_mass).*100;

    colleyNormal=(Colley-median_min_coll)./(median_max_coll...
        -median_min_coll).*100;
    
    eloNormal=(Elo-median_min_elo)./(median_max_elo...
        -median_min_elo).*100;
    
    average_rating=mean([masseyNormal';colleyNormal';eloNormal'])';
    
    folderName = strcat(sport, '/',year,'/ratings/');
    cd(folderName)       
    save('normalizedEloRating.txt','eloNormal','-ascii')
    save('normalizedColleyRating.txt','colleyNormal','-ascii')
    save('normalizedMasseyRating.txt','masseyNormal','-ascii')
    save('averageRating.txt','average_rating','-ascii')
    cd ../../..
        
    
end

    
