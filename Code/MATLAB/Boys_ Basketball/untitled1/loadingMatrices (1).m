function gameStruct = loadingMatrices(year,varargin)
% if nargin == 1, numWeeks = entire season
% if nargin == 2, numWeeks is specified as argument called varargin
%% Change into right directory
lastYear = year-1;
yearString = num2str(year);
lastYearString = num2str(year-1);
nameString = strcat(lastYearString,'-',yearString);
cd(nameString)
%% Store names of folders
folderGames = 'game_matrices/';
folderPD = 'score_diffs/';
folderLoc = 'locations/';
folderOT = 'overtimes/';
folderOofS = 'os_records/';
folderForfeits = 'forfeits/';
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
if nargin == 1
    numWeeks = seasonLength; %This is the season total if there is no argument
elseif nargin == 2
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
%% Create Struct
gameField = "Game"; 
pdField = "PD"; 
locField = "Loc"; 
otField = "OT";
outStateField = "OofS";
forfeitsField = "Forfeits"; 

gameStruct = struct(gameField,Game,pdField,PD,locField,Loc,otField,OT,forfeitsField,forfeits,outStateField,OofS);
%% Change back
cd ..
