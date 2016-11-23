function [sigma,R] = getSpotVol(c,Q,nj)
% getSpotVol estimates the spot volatility at a jump time without assuming
%            the underlying volatility process is continuous at that time
%
% REFERENCE: equation 3.10 in Algorithm 1
%
% INPUT
% c: a njx2 cell of spot covariance estimates, where the first column
%    contains the post-jump spot covarianca estimate, and the second column
%    contains the pre-jump spot covariance estimate
% Q: 2x2 matrix estimator of the jump covariation matrix
% nj: number of jumps in the market returns
%
% OUTPUT
% sigma: njx2 vector containing the local volatility estimates
% R: njx1 cell containing 2x1 vectors used to estimate the local
%    volatility
%

R = cell(nj,1);
sigma = zeros(nj,1);
D = [-Q(1,2)/Q(1,1) 1];

for i = 1:nj
    kappa = unifrnd(0,1);
    xsi_minus = normrnd(0,1,2,1);
    xsi_plus = normrnd(0,1,2,1);
    R{i} = sqrt(kappa)*sqrtm(c{i,1})*xsi_minus+sqrt(1-kappa)*sqrtm(c{i,2})*xsi_plus;
    sigma(i) = D*R{i};
end

end

