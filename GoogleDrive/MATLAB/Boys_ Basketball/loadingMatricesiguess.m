function [Games,Teams,saveFinal] = loadingMatricesiguess(year,varargin)
% if nargin == 1, numWeeks = entire season
% if nargin == 2, numWeeks is specified as argument called varargin
%% Change into right directory
cd(strcat(num2str(year-1),'-',num2str(year)));
shortString = num2str(mod(year,100)); %In case the year is 2000
if strlength(shortString) == 1
    shortString = strcat('0',shortString); %Add a 0 to single digit
end
%% Load Names and Regions 
s = strcat("kybbk_",num2str(year-1),"-",shortString,"_ID_Region_District.txt");
TeamTable = readtable(s);
TeamTable.Properties.VariableNames = {'teamName','ID','new','District'}; %Title the table values
Name = TeamTable.teamName;
Region = TeamTable.new;
District = TeamTable.District; 
%Name, Region, District now stored as variables
%% See if there was an input for the number of weeks
if nargin == 1
    start = 1; %This is the season total if there is no argument
    finish = intmax;
    %saveFinal = true;
elseif nargin == 2
    mat = varargin{1};  %This is the matrix we plug as an argument
    start = mat(1);
    finish = mat(end);
    saveFinal = false;
end
%% Get Game Summaries
data = dir('game_summaries');
nameArray = [];
date = [];
for elem = 1:length(data)
    if contains(data(elem).name,'.txt') && start<=finish%Remove random matlab files
        s = data(elem).name;
        newString = strcat(s(29:30),"/",s(32:33),"/",s(26:27));
        date = [date;newString];
        nameArray = [nameArray; s];
        start = start + 1;
    end
end
summaries = [];
gamesInDay = [];
for elem = 1:length(nameArray(:,1))% Load matrices
    game = nameArray(elem,:);
    loaded = load(strcat('game_summaries/',game));
    s = size(loaded);
    gamesInDay = [gamesInDay; s(1)];
    summaries = [summaries; loaded];
end
%% Create Games array of structs
Games = struct('Winner',{},'Loser',{},'Date',{},'PD',{},'Location',{},'Loc',{},'winID',{},'loseID',{},'winScore',{},'loseScore',{},'forfeit',{},'OT',{},'GameType',{});

summaries(:,1) = summaries(:,1) + 1;
summaries(:,2) = summaries(:,2) + 1;

for elem = 1:length(summaries)%:-1:1
    row = summaries(elem,:);
    tStruct = struct;

    if row(1) > 0
        tStruct.Winner = string(Name(row(1)));
    else
        tStruct.Winner = "OUT_STATE";
    end
    if row(2) > 0 
        tStruct.Loser = string(Name(row(2)));
    else 
        tStruct.Loser = "OUT_STATE";
    end
    while gamesInDay(1) == 0 
        gamesInDay(1) = [];
        date(1) = [];
    end
    gamesInDay(1) = gamesInDay(1) - 1; 
    tStruct.Date = date(1); 
    tStruct.PD = row(5);
    if row(6) == 0 
        tStruct.Location = tStruct.Loser;
    elseif row(6) == 1
        tStruct.Location = tStruct.Winner;
    elseif row(6) == 2
        tStruct.Location = "Neutral"; 
    end
    tStruct.Loc = row(6);
    tStruct.winID = row(1);
    tStruct.loseID = row(2);
    tStruct.winScore = row(3);
    tStruct.loseScore = row(4); 
    if row(3) == 2
        tStruct.forfeit = true;
    else
        tStruct.forfeit = false;
    end
    tStruct.OT = row(7); 
    tStruct.GameType = row(8); 
    Games(end+1) = tStruct; 
end

%% Create Teams struct with fields Name, Region, District
Teams = [];
for i = 1:length(Name)
    tStruct = struct;
    tStruct.Name = string(Name(i));
    tStruct.Record = [];
    tStruct.Rating = [];
    tStruct.Region = Region(i);
    tStruct.District = District(i); 
    tStruct.Wins = [];
    tStruct.Losses = [];
    tStruct.GamesPlayed = [];
    Teams = [Teams; tStruct];
end

cd .. 