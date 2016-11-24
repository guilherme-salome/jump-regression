function [cv,rho,zeta] = jumpRegHT(ret,jump_loc,c,Q,nj,alpha,sim)
% jumpRegHT calculates the critical value of the hypothesis test for the
%           jump beta being a constant
%
% REFERENCE: null hypothesis in equation 3.1, implemented using Algorithm 1
%
% INPUT:
% ret: n*Tx1 vector of market returns
% jump_loc: njx1 vector with location of the jump returns for the market
% c: a njx2 cell of spot covariance estimates, where the first column
%    contains the post-jump spot covarianca estimate, and the second column
%    contains the pre-jump spot covariance estimate
% Q: 2x2 matrix estimator of the jump covariation matrix
% nj: number of jumps in the market return
% alpha: significance level for critical region
%
% OUTPUT:
% cv: 1-alpha critical value for the hypothesis test
% rho: realized jump correlation, used as an alternative way to reject the
%      null hypothesis, but more interpretable
% zeta: simx1 vector of limiting distribution of the determinant of the
%       jump covariation matrix
% 

% sim = 10000; % number of monte carlo simulations
r_d = ret(jump_loc);
aux = sum(r_d.^2); % sum of market return jumps squared

zeta = zeros(sim,1);
parfor m = 1:sim
    [sigma,~] = getSpotVol(c,Q,nj);
    zeta(m) = (aux*sum(sigma.^2))-(sum(r_d.*sigma))^2;
end

cv = quantile(zeta,1-alpha);
rho = Q(1,2)/sqrt(Q(1,1)*Q(2,2));

end

