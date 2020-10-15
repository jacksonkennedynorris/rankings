function [massey_wp]= get_massey_wp(schedule_matrix,neutral_matrix,masseyRatings)

%Schedule matrix, remove trimble county 
%schedule_matrix(:,206)=[];

%Important values
HFA=2.0;
G=schedule_matrix;
b=0.1409;
ones_matrix=ones(size(neutral_matrix));

%Solve rating diff
rating_diff= G * masseyRatings;

%Add HFA to home games, 1 if H/a 0 if not
not_neutral= ones_matrix - neutral_matrix;

HFA_matrix=not_neutral * HFA;

final_rating_diff=HFA_matrix + rating_diff;

%Matrix of win percentages 
massey_wp=glmval(b,final_rating_diff,'logit','constant','off');



