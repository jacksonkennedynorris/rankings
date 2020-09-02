function writeToFile(total,sport,year,whichOne)
if whichOne == 7 
    tablestring = strcat(sport,'/',year,'/ratings/finalTable.csv');
    shortstring = 'finalTable.csv';
elseif whichOne == 1
    tablestring = strcat(sport,'/',year,'/ratings/a1.csv'); 
    shortstring = 'a1.csv'; 
elseif whichOne == 2
    tablestring = strcat(sport,'/',year,'/ratings/a2.csv'); 
    shortstring = 'a2.csv'; 
elseif whichOne == 3 
    tablestring = strcat(sport,'/',year,'/ratings/a3.csv'); 
    shortstring = 'a3.csv'; 
elseif whichOne == 4 
    tablestring = strcat(sport,'/',year,'/ratings/a4.csv'); 
    shortstring = 'a4.csv';
elseif whichOne == 5
    tablestring = strcat(sport,'/',year,'/ratings/a5.csv'); 
    shortstring = 'a5.csv'; 
elseif whichOne == 6 
    tablestring = strcat(sport,'/',year,'/ratings/a6.csv'); 
    shortstring = 'a6.csv'; 
end
    
    writetable(total,tablestring)
    cd ../../../github/rankings/
    writetable(total,shortstring)
    cd ../../
    matlabString = 'Google Drive (jackson.norris@centre.edu)/Summer 2019 Research/MATLAB/';
    cd(matlabString)