function [date,nameArray] = getGameSummaries(year)
%% Get Game Summaries
cd(strcat(num2str(year-1),'-',num2str(year)));
data = dir('game_summaries');
nameArray = [];
date = [];
for elem = 1:length(data)
    if contains(data(elem).name,'.txt')  %Remove random matlab files
        s = data(elem).name;
        newString = strcat(s(29:30),"/",s(32:33),"/",s(26:27));
        date = [date;newString];
        nameArray = [nameArray; s];
    end
end
cd ..