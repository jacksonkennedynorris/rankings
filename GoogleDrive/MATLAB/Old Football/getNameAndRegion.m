function [Name,Region] = getNameAndRegion(year)
%% Read the table and create Name matrix
if ismember(year,['2011','2012','2013','2014','2015','2016','2017','2018']) %The different conditions represent the differences in the data Shelby provided
    TeamTable = readtable(strcat('Football/',year,'/Team Tags/IDpage',year,'.txt')); %Read the table Shelby created
    TeamTable.Properties.VariableNames = {'teamName','ID','new','District'}; %Title the table values
    RegionArray = TeamTable.new;
    Name = TeamTable.teamName;
elseif ismember(year,['2019'])
    TeamTable = readtable(strcat('Football/',year,'/Team Tags/IDPage',year,'.txt')); 
    TeamTable.Properties.VariableNames = {'teamName','ID','new'};
    RegionArray = TeamTable.new; 
    Name = TeamTable.teamName;
elseif ismember(year,['1998','1999','2007-2010'])
    TeamTable = readtable(strcat('Football/',year,'/Team Tags/IDpage',year,'.csv'));
    TeamTable = TeamTable(:,1:2);
    TeamTable.Properties.VariableNames = {'teamName','new'};
    RegionArray = TeamTable.new;
    Name = TeamTable.teamName;
else 
    TeamTable = readtable(strcat('Football/',year,'/Team Tags/IDpage',year,'.csv'));
    TeamTable = TeamTable(:,1:3);
    TeamTable.Properties.VariableNames = {'teamName','new','District'};
    RegionArray = TeamTable.new;
    Name = TeamTable.teamName;
end
%% This section of code names Region and fixes the issue of mixmatched years 
if isa(RegionArray,'double') %No issue
    Region = RegionArray; 
else  %If there is an issue
    RegionRows = [];
    for elem = 1:length(RegionArray)
        RegionRows(elem) = str2double(RegionArray(elem));
    end
    Region = RegionRows'; %Convert to column vector 
end 
