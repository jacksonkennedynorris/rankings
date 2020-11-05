function [elo_wp]= get_elo_wp(schedule_matrix,neutral_matrix,eloRatings)

% ELO
s = 220;
HFA = 11;

%Schedule matrix, remove trimble county (for 2019)
%schedule_matrix(:,206)=[];
G=schedule_matrix;
ones_matrix=ones(size(neutral_matrix));

%Solve rating diff
rating_diff= G * eloRatings;

%Add HFA to home games, 1 if H/a 0 if not
not_neutral= ones_matrix - neutral_matrix;

HFA_matrix=not_neutral * HFA;

final_rating_diff=HFA_matrix + rating_diff;

%Matrix of win percentages 
%massey_wp=glmval(b,final_rating_diff,'logit','constant','off');
elo_wp = 1-1./(1+10.^((final_rating_diff)./s));
%elo_wp=elo_wp';
