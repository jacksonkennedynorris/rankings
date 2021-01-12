mmin = [];
cmin = []; 
emin = []; 
mmax = []; 
cmax = []; 
emax = []; 
sport = "Football";
sport = "Boys Basketball"

for year = 2000:2020
    folder = pwd + "/" + sport + "/Data/" + num2str(year) + "/Ratings/";
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
    
    mmin = [mmin; MassMin]; 
    cmin = [cmin; CollMin]; 
    emin = [emin; EloMin]; 
    mmax = [mmax; MassMax]; 
    cmax = [cmax; CollMax]; 
    emax = [emax; EloMax]; 
end
massmin = median(mmin)
collmin = median(cmin)
emin = median(emin)
mmax = median(mmax)
cmax = median(cmax)
emax = median(emax)