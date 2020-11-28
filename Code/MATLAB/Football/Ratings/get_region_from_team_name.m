function region = get_region_from_team_name(year, name) 

cd .. 
cd Teams 
my_t = readtable(strcat(num2str(year), "_teams.txt"));
for elem = 1:height(my_t)
    region = my_t{elem,2};
end 
cd .. 
cd Ratings
