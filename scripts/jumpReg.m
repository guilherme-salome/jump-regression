function [beta,beta_tilde] = jumpReg(sret,ret,Q,c,jump_loc,nj)
% jumpReg calculates the jump beta using optimal weights
%
% INPUT
% sret: n*Tx1 vector of stock returns
% ret: n*Tx1 vector of market returns
% Q: 2x2 matrix estimator of the jump covariation matrix
% c: njx2 cell of 2x2 matrices that estimate the post-jump and pre-jump
%    spot covariance at the jump times
% jump_loc: njx2 vector containing the indices of the market return jumps
% nj: number of jumps in the market return
%
% OUTPUT
% beta: jump beta that minimizes the F-conditional asymptotic variance
% beta_tilde: consistent estimator for true jump beta
%

beta_tilde = Q(1,2)/Q(1,1);
numerator = 0;
denominator = 0;
for i = 1:nj
    w_star = 2/([-beta_tilde 1]*(c{i,2}+c{i,1})*[-beta_tilde; 1]);
    numerator = numerator + w_star*ret(jump_loc(i))*sret(jump_loc(i));
    denominator = denominator + w_star*(ret(jump_loc(i))^2);
end
beta = numerator/denominator;

end

