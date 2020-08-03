function  print2FileFunctionCurrent(data)
Massey = data.Massey;
Colley = data.Colley; 
Elo = data.Elo; 
 
% sport = data.sport; 
% Name = data.Name; 
% Game = data.Game; 
% PD = data.PD; 
% Loc = data.Loc; 
% NameRecord = data.NameRecord; 
% IMass = data.IMass; 
% IColl = data.IColl; 
% IElo = data.IElo; 

lastYearString = num2str(year-1);
yearString = num2str(year);
nameString = strcat(lastYearString,'-',yearString,'/ratings/');
cd(nameString);
% shortString = yearString(end-1:end);
% 
%     folderName = strcat(sport,'/',year,'/ratings/');
%     current = pwd
%     cd(folderName)       
    save('eloRating.txt','Elo','-ascii')
    save('colleyRating.txt','Colley','-ascii')
    save('masseyRating.txt','Massey','-ascii')
%     save('gameMatrix.txt','Game','-ascii')
%     save('pointDiff.txt','PD','-ascii')
%     save('locations.txt','Loc','-ascii')
%     save('iMass.txt','IMass','-ascii')
%     save('iColl.txt','IColl','-ascii')
%     save('iElo.txt','IElo','-ascii')
%     nameID = fopen('nameMatrix.txt','w');
%     fprintf(nameID,'%s\n',Name{:});
%     fclose(nameID);
%     nameRecordID = fopen('nameRecordMatrix.txt','w');
%     fprintf(nameRecordID,'%s\n',NameRecord{:});
%     fclose(nameRecordID);
    cd ../..
