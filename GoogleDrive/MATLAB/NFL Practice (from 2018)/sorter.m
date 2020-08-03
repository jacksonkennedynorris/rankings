function myTable = sorter(Name,Massey,Colley,Elo)
%% Sort in descending fashion
%First element is the value, second is index
[sortMass,Imass] = sort(Massey,'descend');%Imass is the vector of the Name's index in the order that we sort 
[sortColl,Icoll] = sort(Colley,'descend');
[sortElo,IElo] = sort(Elo,'descend');
%% Find the name of the team in the sort order 
MassName = Name(Imass);
CollName = Name(Icoll);
EloName = Name(IElo);
%% Write a list of numbers in order (that is the length of the number of teams)
myLength = length(sortElo);%Arbitrarily picked elo 
finalOrder = [];
for elem = 1:myLength
   finalOrder=[finalOrder;elem];
end
%% Create final table
myTable = table(finalOrder,MassName,sortMass,CollName,sortColl,EloName,sortElo);