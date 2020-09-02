function [firstTable,secondTable,thirdTable,fourthTable,fifthTable,sixthTable,totalTable] = sortIntoAggregate(data,Average,year)%Name,Region,Average,year,inState,outState)
Name = data.Name; 
Region = data.Region;

inState = data.inStateRecord; 
outState = data.outOfStateRecord; 
%% Initialize Variables
FirstName = []; SecondName = []; ThirdName = []; FourthName = []; FifthName = []; SixthName = [];
FirstSort = [];SecondSort = [];ThirdSort = [];FourthSort = [];FifthSort = [];SixthSort = [];
FirstIn = []; SecondIn = []; ThirdIn = []; FourthIn = []; FifthIn = []; SixthIn = [];
FirstOut = []; SecondOut = []; ThirdOut = []; FourthOut = []; FifthOut = []; SixthOut = [];
%% Iterate through the region matrix to separate teams by region
for elem = 1:length(Region)
    if Region(elem) == 1 %Single A
        name = Name(elem); %Find the name of the team
        ranking = Average(elem);
        inRec = inState(elem);
        outRec = outState(elem); 
        FirstName = [FirstName;name]; 
        FirstSort = [FirstSort;ranking];
        FirstIn = [FirstIn; inRec];
        FirstOut = [FirstOut; outRec];
    elseif Region(elem) == 2 %Repeat above for all six regions
        name = Name(elem);
        ranking = Average(elem);
        inRec = inState(elem); 
        outRec = outState(elem); 
        SecondName = [SecondName;name];
        SecondSort = [SecondSort;ranking];
        SecondIn = [SecondIn; inRec];
        SecondOut = [SecondOut; outRec];
    elseif Region(elem) == 3
        name = Name(elem);
        ranking = Average(elem);
        inRec = inState(elem); 
        outRec = outState(elem);         
        ThirdName = [ThirdName;name];
        ThirdSort = [ThirdSort;ranking];
        ThirdIn = [ThirdIn; inRec]; 
        ThirdOut = [ThirdOut; outRec]; 
    elseif Region(elem) == 4
        name = Name(elem);
        ranking = Average(elem);
        inRec = inState(elem); 
        outRec = outState(elem); 
        FourthName = [FourthName;name];
        FourthSort = [FourthSort;ranking];
        FourthIn = [FourthIn; inRec]; 
        FourthOut = [FourthOut; outRec]; 
    elseif Region(elem) == 5
        name = Name(elem);
        ranking = Average(elem);
        inRec = inState(elem); 
        outRec = outState(elem); 
        FifthName = [FifthName;name];
        FifthSort = [FifthSort;ranking];
        FifthIn = [FifthIn; inRec]; 
        FifthOut = [FifthOut; outRec]; 
    elseif Region(elem) == 6
        name = Name(elem);
        ranking = Average(elem);
        inRec = inState(elem); 
        outRec = outState(elem);        
        SixthName = [SixthName;name];
        SixthSort = [SixthSort;ranking];
        SixthIn = [SixthIn; inRec]; 
        SixthOut = [SixthOut; outRec]; 
    end
end

firstTable = createAggregateTable(FirstName,FirstSort,FirstIn,FirstOut);
secondTable = createAggregateTable(SecondName,SecondSort,SecondIn,SecondOut);
thirdTable = createAggregateTable(ThirdName,ThirdSort,ThirdIn,ThirdOut);
fourthTable = createAggregateTable(FourthName,FourthSort,FourthIn,FourthOut);
if str2double(year) >= 2007
    fifthTable = createAggregateTable(FifthName,FifthSort,FifthIn,FifthOut);
    sixthTable = createAggregateTable(SixthName,SixthSort,SixthIn,SixthOut);
else
    fifthTable = [];
    sixthTable = [];
end

totalTable = createAggregateTableFinal(Name,Average,inState,outState,Region);