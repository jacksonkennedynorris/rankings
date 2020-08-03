function [initElo] = initialElo(data)
numRegions = max(data.Region);
year = data.year;

%% Create all the adjustments
lastYear = year-1;
twoYears = lastYear-1;
threeYears = twoYears-1;
fourYears = threeYears-1;
fiveYears = fourYears-1;
lastYear = year-1;
twoYears = lastYear-1;
threeYears = twoYears-1;
fourYears = threeYears-1;
fiveYears = fourYears-1;
%Create list of strings with all the years 
sport = data.sport; 
lastString = strcat(sport,'/',lastYear,'/ratings/eloAdjustments.txt');
twoString = strcat(sport,'/',twoYears,'/ratings/eloAdjustments.txt');
threeString = strcat(sport,'/',threeYears,'/ratings/eloAdjustments.txt');
fourString = strcat(sport,'/',fourYears,'/ratings/eloAdjustments.txt');
fiveString = strcat(sport,'/',fiveYears,'/ratings/eloAdjustments.txt');
% 
% if year == '2013'
numRegions = max(data.Region);
% year = str2double(year); %Start with year as a double

%% Create all the adjustments
lastYear = year-1;
twoYears = lastYear-1;
threeYears = twoYears-1;
fourYears = threeYears-1;
fiveYears = fourYears-1;

year = num2str(year);%Switch years back to strings
lastYear = num2str(lastYear);
twoYears = num2str(twoYears);
threeYears = num2str(threeYears); 
fourYears = num2str(fourYears); 
fiveYears = num2str(fiveYears);

%Create list of strings with all the years 
lastString = strcat(sport,'/',lastYear,'/ratings/eloAdjustments.txt');
twoString = strcat(sport,'/',twoYears,'/ratings/eloAdjustments.txt');
threeString = strcat(sport,'/',threeYears,'/ratings/eloAdjustments.txt');
fourString = strcat(sport,'/',fourYears,'/ratings/eloAdjustments.txt');
fiveString = strcat(sport,'/',fiveYears,'/ratings/eloAdjustments.txt');
 

%Load the data 
lastAdj = load(lastString);
twoYearAdj = load(twoString);
threeYearAdj = load(threeString);
fourYearAdj = load(fourString);
fiveYearAdj = load(fiveString);

%Complete a weighted average of the last few years (five in this instance) 
scalars = [5 4 3 2 1];
adjustments = [lastAdj,twoYearAdj,threeYearAdj,fourYearAdj,fiveYearAdj];
adj = scalars.*adjustments;
scaledAdj = sum(adj')/sum(scalars);
scaledAdj = scaledAdj';

%Load the elo rating
eloString = strcat(sport, '/',lastYear,'/ratings/eloRating.txt');
lastElo = load(eloString);

%Find the strings of last year's teams
lastNameString = strcat(sport,'/',lastYear,'/ratings/nameMatrix.txt');
fileID = fopen(lastNameString,'r');
lastName = textscan(fileID,'%s','Delimiter','\n');
fclose(fileID);

lastName = lastName{1,1};

%% Initialize the initElo matrix 
initElo = [];

for elem = 1:length(data.Name) 
     myIndex = data.Region(elem);
     if ~isnan(myIndex) && ~isempty(scaledAdj)
        whichScale = scaledAdj(myIndex);
%         whichScale = 0;
     else
        whichScale = 0;
     end
    [inOld,oldElem] = ismember(data.Name(elem),lastName);
    if inOld
        initElo(elem) = (1/3)*lastElo(oldElem) + (2/3)*(1500+whichScale); %%ASK IF lastElo(elem) IS CORRECT
    else 
        initElo(elem) = (1/3)*(1500) + (2/3)*(1500+whichScale);
    end
end
initElo = initElo';