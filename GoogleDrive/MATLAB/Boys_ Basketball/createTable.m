function [myTable,Imass,Icoll,IElo] = createTable(Name,Massey,Colley,Elo)
%% Sort in descending fashion
%First element is the value, second is index
[Mass,Imass] = sort(Massey,'descend');%Imass is the vector of the Name's index in the order that we sort 
[Coll,Icoll] = sort(Colley,'descend');
[Elo,IElo] = sort(Elo,'descend');
%% Find the name of the team in the sort order 
MassName = Name(Imass);
CollName = Name(Icoll);
EloName = Name(IElo);
%% Write a list of numbers in order (that is the length of the number of teams)
myLength = length(Elo);%Arbitrarily picked elo 
rank = [];
for elem = 1:myLength
   rank=[rank;elem];
end
%% Create final table
myTable = table(rank,MassName',Mass,CollName',Coll,EloName',Elo);