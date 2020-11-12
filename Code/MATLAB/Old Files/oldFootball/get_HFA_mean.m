%Analysis of HFA 


function HFA_mean = get_HFA_mean(ptsWonMatrix)

HFA_mean = mean(ptsWonMatrix(:,1)- ptsWonMatrix(:,2))/2;

%histogram((ptsWonMatrix(:,1)- ptsWonMatrix(:,2))/2)

plot(ptsWonMatrix(:,1), ptsWonMatrix(:,2),'*')
lsline

polyfit(ptsWonMatrix(:,1), ptsWonMatrix(:,2),1)
