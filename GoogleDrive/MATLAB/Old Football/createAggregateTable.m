function myTable = createAggregateTable(Name,Average,inState,outState)
% [Aver,Iaver] = sort(Average,'descend');
% AverName = Name(Iaver);
% %% Write a list of numbers in order (that is the length of the number of teams)
% myLength = length(Aver);
% rank = [];
% for elem = 1:myLength
%    rank=[rank;elem];
% end
% %% Create final table
% myTable = table(rank,AverName,Aver);
[Rating,Iaver] = sort(Average,'descend');
Name_Of_Team = Name(Iaver);
In_State_Record = inState(Iaver);
Total_Record = outState(Iaver); 
%% Write a list of numbers in order (that is the length of the number of teams)
myLength = length(Rating);
Rank = [];
for elem = 1:myLength
   Rank=[Rank;elem];
end
%% Create final table
myTable = table(Rank,Name_Of_Team,Rating,In_State_Record,Total_Record);