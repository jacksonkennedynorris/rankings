function [Massey,Colley,Elo,average] = getRatings(sport,year)

allFolders = strcat(sport,'/',year,'/ratings/');

masseyFolder = strcat(allFolders,'masseyRating.txt');
colleyFolder = strcat(allFolders,'colleyRating.txt');
eloFolder = strcat(allFolders,'eloRating.txt');
listOfNames = strcat(allFolders,'listOfNames.txt');

averageFile = strcat(allFolders,'averageRating.txt');

Massey = load(masseyFolder);
Colley = load(colleyFolder);
Elo = load(eloFolder);

average = load(averageFile);

