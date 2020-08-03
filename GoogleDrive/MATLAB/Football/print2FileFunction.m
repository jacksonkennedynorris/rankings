function    print2FileFunction(print2File,Massey,Colley,Elo,year,eloAdjustments,sport,Name,Game,PD,Loc,inColley,inElo,NameRecord,IMass,IColl,IElo,OutState,InState)

%letsNameIt = double(Name)

if print2File
    folderName = strcat(sport, '/',year,'/ratings/');
    cd(folderName)       
    save('eloRating.txt','Elo','-ascii')
    save('colleyRating.txt','Colley','-ascii')
    save('masseyRating.txt','Massey','-ascii')
    save('eloAdjustments.txt','eloAdjustments','-ascii')
%     save('listOfNames.txt','letsNameIt','-ascii')
    save('gameMatrix.txt','Game','-ascii')
    save('pointDiff.txt','PD','-ascii')
    save('locations.txt','Loc','-ascii')
    save('inColley.txt','inColley','-ascii')
    save('inElo.txt','inElo','-ascii')
    save('iMass.txt','IMass','-ascii')
    save('iColl.txt','IColl','-ascii')
    save('iElo.txt','IElo','-ascii')
    save('outState.txt','OutState','-ascii')
    save('inState.txt','InState','-ascii')
    
    %fprintf('nameMatrix.txt','%s\n',transposeName{:})
    nameID = fopen('nameMatrix.txt','w');
    fprintf(nameID,'%s\n',Name{:});
    fclose(nameID);
    nameRecordID = fopen('nameRecordMatrix.txt','w');
    fprintf(nameRecordID,'%s\n',NameRecord{:});
    fclose(nameRecordID);
    cd ../../..

    
    
end

%         eloFile = 'elo.txt';
%         masseyFile = 'massey.txt';
%         colleyFile = 'colley.txt';
%         save Massey -ascii
%         save Colley 
%         save year 
%         save eloAdjustments
%         fileID = fopen(fileName,'w');
%         formatSpec = '%6.2f\n';
%         fprintf(fileID,formatSpec,Elo);%year,Massey,Colley,Elo,eloAdjustments);
%         fclose(fileID);


%     myString = strcat(sport, '/',year,'/ratings/eloRating.txt');
%     x = load(myString);