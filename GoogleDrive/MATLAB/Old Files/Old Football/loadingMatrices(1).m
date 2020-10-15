function [Game,PD,Loc,OofS,forfeits] = loadingMatrices(year,sport,varargin)
% if nargin == 2, numWeeks = entire season
% if nargin == 3, numWeeks is specified as argument called varargin
%% Store the folder names 
folderGames = strcat(sport, '/',year,'/game_matrices/'); 
folderPD = strcat(sport, '/',year,'/score_diffs/');
folderLoc = strcat(sport, '/',year,'/locations/');
folderOT = strcat(sport, '/',year,'/overtimes/');
folderOofS = strcat(sport, '/',year,'/os_records/');
folderForfeits = strcat(sport, '/',year,'/forfeits/');
%% Creates an array of the different files
gameFiles = dir(folderGames);
nameArray = [];
seasonLength = 0;
for elem = 1:length(gameFiles)
    if contains(gameFiles(elem).name,'.txt')
        myString = strcat(gameFiles(elem).name);
        nameArray = [nameArray; myString];
        seasonLength = seasonLength + 1;
    end
end
nameMat = [];
for elem = 1:length(nameArray(:,1))
    nameMat = [nameMat; string(nameArray(elem,:))]; %String array the way we need the files
end
%% See if there was an input for the number of weeks
if nargin == 2
    numWeeks = seasonLength; %This is the season total if there is no argument
elseif nargin == 3
    numWeeks = varargin{1}; %This is the number we plug as an argument
end
%% Initialize Variables
Game = [];PD = [];Loc = [];OT = []; OofS = []; forfeits = [];
%% Iterate through the list of gamefiles
for i = 1:length(nameMat)
    
    gameString = nameMat(i); %game string should be the name of the file with the game matrices
    shortString = erase(gameString,"matrix");

    %Create strings 
    gameString = strcat(folderGames,gameString);
    PDString = strcat(folderPD,'score_diffs',shortString);
    LocString = strcat(folderLoc,'locations',shortString);
    OTString = strcat(folderOT,'overtimes',shortString);
    OofSString = strcat(folderOofS,'os_record',shortString);
    ForfeitsString = strcat(folderForfeits,'forfeits',shortString);
    
    %Update the values of the variables
    Game = [Game;load(gameString)];
    PD = [PD; load(PDString)];
    Loc = [Loc; load(LocString)];
    OT = [OT;load(OTString)];
    OofS = [OofS;load(OofSString)];
    forfeits = [forfeits;load(ForfeitsString)];
end
%% Change the Overtime games to 1/2 PD
for elem = 1:length(OT) 
    if OT(elem) == 1
        PD(elem) = 1/2;
    end
end
