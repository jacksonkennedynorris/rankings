function data = removeTeamsEmptyStrings(data)
for elem = 1:length(data.Name) 
    if data.Name(elem) == ""
        disp("HELLO") 
    end
end
