function [colley_wp]= get_colley_wp(schedule_matrix,neutral_matrix,colleyRatings)

%Schedule matrix, remove trimble county 
%schedule_matrix(:,206)=[];

%Important values 
HFA= 0.01;
G=schedule_matrix; 
b=8.1372; % from get_colley_parameters
ones_matrix=ones(size(neutral_matrix));

%Solve rating diff
rating_diff= G * colleyRatings;

%Add HFA to home games, 1 if H/a 0 if not
not_neutral= ones_matrix - neutral_matrix;

HFA_matrix=not_neutral * HFA;

final_rating_diff=HFA_matrix + rating_diff;

%Matrix of win percentages 
colley_wp=glmval(b,final_rating_diff,'logit','constant','off');



