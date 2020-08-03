function [colley_test,matchingHFA] = colley_wrapper(years)

colley_test=[];
matchingHFA=[];

for mainHFA = 0:0.001:0.005
    for ratingHFA = 0:0.01:0.1
        matchingHFA=[matchingHFA; mainHFA ratingHFA]; %#ok<AGROW>
        colley_test=[colley_test;main_test(years,mainHFA,ratingHFA)]; %#ok<AGROW>
    end
end
    