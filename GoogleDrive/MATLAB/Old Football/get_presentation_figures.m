% get_presentation_figures.m 

k1=15;
k2=15;

[predMargin actualMargin] = meshgrid([0:35],[0:35]);
%marg_weights = 1 - (1-exp(-predMargin/k1)).*(1-exp(-actualMargin/k2));
%marg_weights = (1-1./(1+exp(-(predMargin-21)/5))).*(1-1./(1+exp(-(actualMargin-21)/5)));
marg_weights = (1-1./(1+exp(-(min(predMargin,actualMargin)-35)/3)));


mesh(predMargin, actualMargin, marg_weights)
xlabel('Pred Margin')
ylabel('Actual Margin')
zlabel('Weight')

% weeksAgo = [0:10];
% time_weights = .95.^weeksAgo;
% plot(weeksAgo, time_weights, '*')
% xlabel('Weeks Ago')
% ylabel('Weight')
% axis([0 10 0 1])