function data = calculateRecord(data)
%[NameRecord,Name,outOfStateRecord,inStateRecord]
Name = data.Name; 
OofS = data.OofS; 
Game = data.Game; 
PD = data.PD; 
Region = data.Region; 
%% Figure out who won and lost in state
WorL = [];

for elem = 1:length(Name)
    w = find(Game(:,elem)==1);
    l = find(Game(:,elem)==-1);

    win = length(w);
    loss = length(l);

    entry = [win,loss];
    WorL = [WorL;entry];
end
%% Generate list of strings in state
inStateRecord = [];
for elem = 1:length(Name)
    win = WorL(elem,1);
    loss = WorL(elem,2);
    tempArray = [win,loss];
    tempString = string(tempArray);
    myString = strcat(tempString(1),'-',tempString(2));
    inStateRecord = [inStateRecord; myString];
end
%% Calculate Out of State wins/losses
WorLoutState = [];
if ~isempty(OofS) %How to find the out of state wins and losses
    for elem = 1:length(Name) 
        w = find(OofS(:,elem)==1);
        l = find(OofS(:,elem)==-1);
        win = length(w);
        loss = length(l);
        entry = [win,loss];
        WorLoutState = [WorLoutState; entry];
    end
end
%% Generate Out of State List of Strings
outOfStateRecord = [];
if ~isempty(OofS)
    for elem = 1:length(Name)
        win = WorLoutState(elem,1);
        loss = WorLoutState(elem,2);
        winIn = WorL(elem,1);
        lossIn = WorL(elem,2);
        tempArray = [win+winIn,loss+lossIn];
        tempString = string(tempArray);
        myString = strcat(tempString(1),'-',tempString(2));
        outOfStateRecord = [outOfStateRecord; myString];
    end
else
    outOfStateRecord = inStateRecord;
end
%% Create final string
generateNameWithRecord = [];
for elem = 1:length(Name)
    tempString = strcat(Name(elem),"  ",outOfStateRecord(elem)," (",inStateRecord(elem),")");
    generateNameWithRecord = [generateNameWithRecord;tempString];
end
NameRecord = generateNameWithRecord;

data.NameRecord = NameRecord;
data.outOfStateRecord = outOfStateRecord; 
data.inStateRecord = inStateRecord;
 
%NameRecord,Name,outOfStateRecord,inStateRecord
