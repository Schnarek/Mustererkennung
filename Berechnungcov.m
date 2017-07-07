function [] = Berechnungcov(r_c1x,r_c1y)
% calc mean 
sum_x = sum(r_c1x(:,1));
mw_x = sum_x/length(r_c1x);

sum_y = sum(r_c1y(:,1));
mw_y = sum_y/length(r_c1y);

% Covarianz AA (Varianz)
 cov_AA = sum((r_c1x(:,1) - mw_x) .* (r_c1x(:,1) -  mw_x)/(length(r_c1x)-1));
% Covarianz AB
 cov_AB = sum((r_c1x(:,1) - mw_x) .* (r_c1y(:,1) -  mw_y)/(length(r_c1x)-1));
% Covarianz BA
 cov_BA = sum((r_c1y(:,1) - mw_y) .* (r_c1x(:,1) - mw_x) /(length(r_c1x)-1));
% Covarianz BB
 cov_BB = sum((r_c1y(:,1) - mw_y) .* (r_c1y(:,1) -  mw_y)/(length(r_c1x)-1));
 
cov_MA = [ cov_AA,cov_AB;cov_BA,cov_BB];
 % cov_MA == Sigma
mu = [mw_x mw_y];
Sigma = [cov_AA cov_AB; cov_BA cov_BB];

rng default  % For reproducibility
r = mvnrnd(mu,Sigma,100);
figure
title('Bivariate Normalverteilung')
xlabel('X1'); 
ylabel('X2');
hold on;
plot(r(:,1),r(:,2),'+')
end

