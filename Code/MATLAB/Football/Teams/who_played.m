names = {};
matrix = zeros(241, length(1998:2019)); 
for year = 2019:-1:1998 
    index_year = year - 1997; 
    string = strcat(num2str(year),"_teams.txt");
    my_table = readtable(string);
    the_names = my_table{:,1};
    length(the_names)
    for elem = 1:length(the_names)
        if ~ismember(the_names{elem},names) && ~ismember(the_names{elem}(1:end-1), names)
            names{end+1} = the_names{elem};
            matrix(length(names), index_year) = 1; 
        else
            [~,one] = ismember(the_names{elem},names);
            [~,two] = ismember(the_names{elem}(1:end-1),names);
            three = max([one, two]);
            matrix(three, index_year) = 1; 
        end
    end
end
size(names') 
size(matrix)
my_table = table(names', matrix) 
matrix
names = cell2table(names');
names.Properties.VariableNames = {'Team'};
names = sortrows(names);
writetable(names, "total_teams.txt");