function HFA_mean = get_HFA_mean(ptsWonMatrix)

%Graphs HFA in order to calculate mean, slope=HFA

HFA_mean = mean(ptsWonMatrix(:,1)- ptsWonMatrix(:,2))/2;

%histogram((ptsWonMatrix(:,1)- ptsWonMatrix(:,2))/2)

plot(ptsWonMatrix(:,1), ptsWonMatrix(:,2),'*')
lsline

polyfit(ptsWonMatrix(:,1), ptsWonMatrix(:,2),1)