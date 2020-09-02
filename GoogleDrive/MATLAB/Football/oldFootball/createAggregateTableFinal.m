function myTable = createAggregateTableFinal(Name,Average,inState,outState,Region)
[Rating,Iaver] = sort(Average,'descend');
Name_Of_Team = Name(Iaver);
In_State_Record = inState(Iaver);
Total_Record = outState(Iaver); 
Region_Of_Team = Region(Iaver);
%% Write a list of numbers in order (that is the length of the number of teams)
myLength = length(Rating);
Rank = [];
for elem = 1:myLength
   Rank=[Rank;elem];
end
%% Create final table
myTable = table(Rank,Region_Of_Team,Name_Of_Team,Rating,In_State_Record,Total_Record);