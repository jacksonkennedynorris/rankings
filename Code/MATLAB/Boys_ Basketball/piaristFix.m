function data = piaristFix(data)

%data.PD(700)
data.Game(:,203) = [];
data.OofS(:,203) = [];
data.Game(720,:) = [];
data.PD(720) = []; 
data.Loc(720) = []; 
data.forfeits(720) = [];
data.OT(720) = [];