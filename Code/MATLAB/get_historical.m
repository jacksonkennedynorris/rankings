function [MassMin, MassMax, CollMin, CollMax, EloMin, EloMax] = get_historical(year) 

folder = pwd + "/Data/" + num2str(year) + "/Ratings/";
massey = readtable(folder + "masseyRating.txt");
colley = readtable(folder + "colleyRating.txt");
elo = readtable(folder + "eloRating.txt");

massey = massey{:,2};
colley = colley{:,2};
elo = elo{:,2};


MassMin = min(massey); 
CollMin = min(colley); 
EloMin = min(elo);
MassMax = max(massey); 
CollMax = max(colley); 
EloMax = max(elo); 