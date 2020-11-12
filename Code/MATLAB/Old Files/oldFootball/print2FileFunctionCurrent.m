function    print2FileFunctionCurrent(data)
Massey = data.Massey;
Colley = data.Colley; 
Elo = data.Elo; 
year = data.year; 
sport = data.sport; 
Name = data.Name; 
Game = data.Game; 
PD = data.PD; 
Loc = data.Loc; 
NameRecord = data.NameRecord; 
IMass = data.Imass; 
IColl = data.Icoll; 
IElo = data.IElo; 
year = data.year;
year = num2str(year);


    folderName = strcat(sport,'/',year,'/ratings/');
    cd(folderName)       
    save('eloRating.txt','Elo','-ascii')
    save('colleyRating.txt','Colley','-ascii')
    save('masseyRating.txt','Massey','-ascii')
    save('gameMatrix.txt','Game','-ascii')
    save('pointDiff.txt','PD','-ascii')
    save('locations.txt','Loc','-ascii')
    save('iMass.txt','IMass','-ascii')
    save('iColl.txt','IColl','-ascii')
    save('iElo.txt','IElo','-ascii')

    nameID = fopen('nameMatrix.txt','w');
    fprintf(nameID,'%s\n',Name{:});
    fclose(nameID);
    nameRecordID = fopen('nameRecordMatrix.txt','w');
    fprintf(nameRecordID,'%s\n',NameRecord{:});
    fclose(nameRecordID);
    cd ../../..

