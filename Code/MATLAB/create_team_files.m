function create_team_files

pwd
cd("Boys_ Basketball")
year = 1999
%changeIntoYearDirectory(year);
cd(strcat(num2str(year-1),'-',num2str(year)))
%% Load Names and Regions 
shortString = num2str(mod(year,100)); %In case the year is 2000
if strlength(shortString) == 1
    shortString = strcat('0',shortString); %Add a 0 to single digit
end
s = strcat("kybbk_",num2str(year-1),"-",shortString,"_ID_Region_District.txt");
TeamTable = readtable(s);
TeamTable.Properties.VariableNames = {'teamName','Code','Region','District'}; %Title the table values
name = TeamTable.teamName;
region = TeamTable.Region;
District = TeamTable.District; 
%Name, Region, District now stored as variables
cd ..
cd ..

table(Name,Region)
% for year = 1998
%     
%     
%     cd(num2str(year) + "-" + num2str(year+1))
%     newyear = num2str(year+1); 
%     code = newyear(end-1:end);
%     mat = readtable("kybbk_" + num2str(year) + "-" + code + "_ID_Region_District.txt")
%     
%     mat.Properties.VariableNames = {'Name' 'Code' 'Region' 'District'}
%     
%     col = 3;
%     region = mat(:,col);
%     
%     newt = (mat(:,1), mat(:,col))
%     
%     cd .. 
%     
%     
% end
% 
% disp("HEY") 
% 
% 
% newt
% 
% 
% disp("HEY")
