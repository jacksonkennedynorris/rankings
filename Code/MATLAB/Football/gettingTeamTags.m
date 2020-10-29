

strings = dir("TeamTags");

stringArray = [];
for elem = 1:length(strings) 
    if contains(strings(elem).name, ".txt") 
        stringArray = [stringArray; strings(elem).name];
    end
end

cd("TeamTags")
x = readtable(stringArray(1,:))
size(x)
x(1, 3)
cd ..



