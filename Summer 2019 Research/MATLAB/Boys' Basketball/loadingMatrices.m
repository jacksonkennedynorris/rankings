function [Games,Teams,saveFinal] = loadingMatrices(year,varargin)
% if nargin == 1, loads entire season
% if nargin == 2, loads up until the second number
% if nargin == 3, loads from first number up to the second number
% if nargin == 4, loads that particular day 
%% Get the name, region, and district of each team
[Name,Region,District] = getTeamData(year);
%% Get the date and nameArray from all the game summaries 
[date,nameArray] = getGameSummaries(year);
%% Varargin
saveFinal = false;
if nargin == 1 %Want the entire season
    start = 1;
    finish = length(nameArray);
    %saveFinal = true;
elseif nargin == 2 %Want up to certain number
    start = 1;
    finish = varargin{1};
elseif nargin == 3 %Want to input a start and a next team
    start = varargin{1};
    finish = varargin{2};
    loadingMatrices(2020,start)
elseif nargin == 4 %Want data from a certain day
    num = useDates(string(num2str(varargin{1})),string(num2str(varargin{2})),string(num2str(varargin{3})),nameArray);
    start = num; 
    finish = num;
end
summaries = [];

gamesInDay = zeros(length(start:finish),1);
for elem = start:finish% Load matrices
    game = nameArray(elem,:);
    loaded = load(strcat(num2str(year-1),'-',num2str(year),'/game_summaries/',game));
    s = size(loaded);
    gamesInDay(elem) = s(1);%[gamesInDay; s(1)];
    summaries = [summaries;loaded];
end
%% Create Games and Teams
Games = createGamesStruct(summaries,Name,gamesInDay,date,year);
Teams = createTeams(Name,Region,District);
%% Calculate Record
[Games,Teams] = calculateRecord(Games,Teams);
%% Remove forfeits 
[Games,Teams] = removeForfeits(Games,Teams);
%% Change OT Point differentials 
[Games,Teams] = changeOT(Games,Teams);