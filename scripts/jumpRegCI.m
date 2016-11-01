function [CI_low, CI_up] = jumpRegCI(beta,alpha,ret,c,Q,jump_loc,nj,delta_n)
% jumpRegCI calculates the confidence intervals for the true jump beta
%           using Monte Carlo simulations
%
% INPUT
% beta: a number; jump beta between the stock and the market
% alpha: a number; significance level, i.e.: 0.01 or 0.05
% ret: a n*Tx1 vector of market returns
% c: njx2 cell containing estimates of the post-jump
%    and the pre-jump spot covariance matrices for each jump time
% Q: 2x2 matrix estimator of the jump covariation matrix
% jump_loc: njx2 vector containing the indices of the market return jumps
% nj: number of jumps in the market return
% delta_n: size of intervals between samples within the day, calculated as
%          1/n
% 
% OUTPUT
% CI_low: lower bound of the confidence interval for the jump beta
% CI_up: upper bound of the confidence interval for the jump beta
%

beta_tilde = Q(1,2)/Q(1,1);
sim = 1000;
zeta = zeros(sim,1);

for m = 1:sim
    [sigma,~] = getSpotVol(c,Q,nj);
    numerator = 0;
    denominator = 0;
    for i = 1:nj
        w_star = 2/([-beta_tilde 1]*(c{i,2}+c{i,1})*[-beta_tilde; 1]);
        numerator = numerator + w_star*ret(jump_loc(i))*sigma(i);
        denominator = denominator + w_star*(ret(jump_loc(i))^2);
    end
    zeta(m,1) = numerator/denominator;
end

cv = quantile(zeta,1-alpha/2);
CI_low = beta-sqrt(delta_n)*cv;
CI_up = beta+sqrt(delta_n)*cv;

end

