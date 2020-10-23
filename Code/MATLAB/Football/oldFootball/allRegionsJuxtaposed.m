function [myCell,crossRegion] = allRegionsJuxtaposed(Game,PD,Loc,Elo,Region,Name)
numRegions = max(Region);
crossRegion = nchoosek(1:numRegions,2);
myCell = cell(length(crossRegion),1);
finalMat = [];name1 = [];rating1 = [];region1 = [];name2 = [];rating2 = [];region2 = [];outcome = []; pointDiff = [];location = [];
for elem = 1:length(Game)
    K = find(Game(elem,:));
    if K 
        i = K(1); 
        j = K(2); 
        
        iWL = Game(elem,i);
        jWL = Game(elem,j);
        
        rate1 = Elo(i);
        rate2 = Elo(j);
        
        reg1 = Region(i);
        reg2 = Region(j);
        
        n1 = Name(i);
        n2 = Name(j); 
        
        loc = Loc(elem);
        pd = PD(elem);
        
        if reg1 > reg2
            reg1original = reg1;
            reg1 = reg2;
            reg2 = reg1original;
            
            rating1original = rate1;
            rate1 = rate2;
            rate2 = rating1original;
            
            newWL = iWL;
            iWL = jWL;
            jWL = newWL;
            
            name = n1;
            n1 = n2;
            n2 = name;
        end   
        if iWL == 1
            oc = 0;
        else
            oc = 1;
        end
        if isnan(reg1) || isnan(reg2)
            continue
        end
        name1 = [name1;n1];
        rating1 = [rating1;rate1];
        region1 = [region1;reg1];
        name2 = [name2;n2];
        rating2 = [rating2;rate2];
        region2 = [region2;reg2];
        outcome = [outcome;oc];
        pointDiff = [pointDiff;pd];
        location = [location;loc];
        
        myMat = [rate1,rate2,oc,pd,loc];
        [~,myIndex] = ismember([reg1 reg2],crossRegion, 'rows');
        myCell{myIndex} = [myCell{myIndex}; myMat];
    end
end

finalTable = table(name1,region1,rating1,name2,region2,rating2,outcome,pointDiff,location);