function num = useDates(month,day,year,nameArray)

if strlength(month) == 1
    month = strcat('0',month); %Add a 0 to single digit
end
if strlength(day) == 1 
    day = strcat('0',day); 
end
if strlength(year) == 1
    year = strcat('0',year');
end

for elem = 1:length(nameArray)
    temp = nameArray(elem,:);
    themonth = temp(29:30);
    theday = temp(32:33);
    theyear = temp(26:27);
    if month == themonth && day == theday && year == theyear
        num = elem;
    end
end
    