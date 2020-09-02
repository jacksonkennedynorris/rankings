function [firstTable,secondTable,thirdTable,fourthTable,fifthTable,sixthTable,totalTable,data] = sortByRegion(data)
%% Store data
Name = data.Name; 
Region = data.Region; 
Massey = data.Massey;
Colley = data.Colley; 
Elo = data.Elo; 
year = data.year; 
%% Initialize Variables
FirstName = []; SecondName = []; ThirdName = []; FourthName = []; FifthName = []; SixthName = [];
FirstSort = [];SecondSort = [];ThirdSort = [];FourthSort = [];FifthSort = [];SixthSort = [];
%% Iterate through the region matrix to separate teams by region
for elem = 1:length(Region)
    if Region(elem) == 1 %Single A
        name = Name(elem); %Find the name of the team
        ranking = [Massey(elem),Colley(elem),Elo(elem)];
        FirstName = [FirstName;name]; 
        FirstSort = [FirstSort;ranking];
    elseif Region(elem) == 2 %Repeat above for all six regions
        name = Name(elem);
        ranking = [Massey(elem),Colley(elem),Elo(elem)];
        SecondName = [SecondName;name];
        SecondSort = [SecondSort;ranking];
    elseif Region(elem) == 3
        name = Name(elem);
        ranking = [Massey(elem),Colley(elem),Elo(elem)];
        ThirdName = [ThirdName;name];
        ThirdSort = [ThirdSort;ranking];
    elseif Region(elem) == 4
        name = Name(elem);
        ranking = [Massey(elem),Colley(elem),Elo(elem)];
        FourthName = [FourthName;name];
        FourthSort = [FourthSort;ranking];
    elseif Region(elem) == 5
        name = Name(elem);
        ranking = [Massey(elem),Colley(elem),Elo(elem)];
        FifthName = [FifthName;name];
        FifthSort = [FifthSort;ranking];
    elseif Region(elem) == 6
        name = [Name(elem),Region(elem)];
        ranking = [Massey(elem),Colley(elem),Elo(elem)];
        SixthName = [SixthName;name];
        SixthSort = [SixthSort;ranking];
    end
end
%% Generate final tables
%SixthName
% Call sorter with Name, Massey, Colley, Elo
[firstTable,~,~,~] = createTable(FirstName,FirstSort(:,1),FirstSort(:,2),FirstSort(:,3));
[secondTable,~,~,~] = createTable(SecondName,SecondSort(:,1),SecondSort(:,2),SecondSort(:,3));
[thirdTable,~,~,~] = createTable(ThirdName,ThirdSort(:,1),ThirdSort(:,2),ThirdSort(:,3));
[fourthTable,~,~,~] = createTable(FourthName,FourthSort(:,1),FourthSort(:,2),FourthSort(:,3));
if str2double(year) >= 2007
    fifthTable = createTable(FifthName,FifthSort(:,1),FifthSort(:,2),FifthSort(:,3));
    sixthTable = createTable(SixthName,SixthSort(:,1),SixthSort(:,2),SixthSort(:,3));
else
    fifthTable = [];
    sixthTable = [];
end
%Total table
[totalTable,Imass,Icoll,IElo] = createTable(Name,Massey,Colley,Elo);
data.Imass = Imass; 
data.Icoll = Icoll; 
data.IElo = IElo; 
