function additions = editEloName(OldName,Name,Elo,firstYear,year)


%OldName,Name
additions = [];
negations = [];
for elem = 1:length(OldName)
    %OldName{elem}
     if ~ismember(Name{elem},OldName)
        additions = [additions;elem];
        added = Name(elem);
%     if ~firstYear
%     length(OldName{elem})
%     length(Name{elem})
%     if OldName{elem} ~= Name{elem}
%         elem;
     end
    if ~ismember(OldName{elem},Name)
        negations = [negations;elem];
        negated = Name(elem);
        year;
    end
    
end
additions;
negations;