function getEloParameters
year = 2020

total = 92;

sMat = 200:5:400;
kMat = 20:1:40;
HFAMat = 1:1:40;
myL = length(sMat)*length(kMat)*length(HFAMat);
finalMat = zeros(myL,6);
for day = 36:total-1
    [oldG,oldT,saveFinal] = loadingMatrices(year,1:day);
    [oldG,oldT] = modifyData(oldG,oldT);
    
    [Games,Teams,~] = loadingMatrices(year,day+1);
    [Games,~] = modifyData(Games,Teams);
    i = 0;
    initElo = initialElo(Teams);
    for s = sMat
        for k = kMat
            for HFA = HFAMat
                Elo = eloRating(oldG,oldT,initElo,k,s,HFA);
                preds = 0;
                total = 0;
                for game = 1:length(Games)
                    win = Games(game).winID;
                    lose = Games(game).loseID;
                    if win == 0 || lose == 0 
                        continue 
                    end
                    Elow = Elo(win); 
                    Elol = Elo(lose);
                    if Elow > Elol 
                        preds = preds + 1; 
                    end
                    total = total + 1;
                end
                 
                small = [preds,total,preds/total*100, s, k, HFA];
                i = i + 1; 
                finalMat(i,:) = finalMat(i,:) + small;
            end
        end
    end
    
end
finalMat = finalMat./ length(36:total-1);
finalMat
disp("DONE")
