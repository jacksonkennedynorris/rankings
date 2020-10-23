function [Name,Region,District] = getTeamData(year)
%changeIntoYearDirectory(year);
cd(strcat(num2str(year-1),'-',num2str(year)))
%% Load Names and Regions 
shortString = num2str(mod(year,100)); %In case the year is 2000
if strlength(shortString) == 1
    shortString = strcat('0',shortString); %Add a 0 to single digit
end
s = strcat("kybbk_",num2str(year-1),"-",shortString,"_ID_Region_District.txt");
TeamTable = readtable(s);
TeamTable.Properties.VariableNames = {'teamName','blank1','Region','District','blank2'}; %Title the table values
Name = TeamTable.teamName;
Region = TeamTable.Region;
District = TeamTable.District; 
%Name, Region, District now stored as variables
cd ..
