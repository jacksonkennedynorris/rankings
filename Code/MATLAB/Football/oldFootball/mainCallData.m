function mainCallData()
clear all 
close all
year = '2019';sport = 'Football';
main(year,sport)

data = allOldStuff(year,sport);%[Name,Region,outState,inState] = allOldStuff(year,sport);

[Massey,Colley,Elo,Average] = getRatings(sport,year);
Average = round(Average,2); 

[one,two,three,four,five,six,total] = sortIntoAggregate(data,Average,year);%,Name,Region,Average,year,inState,outState);
myCell = {one,two,three,four,five,six,total}; %Create a cell of all the matrices 

for elem = 1:7  %7 is if we are printing the total 
    writeToFile(myCell{elem},sport,year,elem)
end
disp("Done with Matlab!")
