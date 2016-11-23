function [r_c,r_d] = separateReturns(ret,cut)
% separateReturns separates diffusive and jump returns
%
% INPUT:
% ret: n*Tx1 vector of returns
% cut: n*Tx1 vector of jump thresholds
%
% OUTPUT:
% r_c: n*Tx1 vector of diffusive returns, with zeroes where the returns are
%      jump returns
% r_d: n*Tx1 vector of jump returns, with zeroes where the returns are
%      diffusive returns
%

r_c = ret;
r_c(abs(r_c) > cut) = 0; % if return is jump, set it to zero

r_d = ret;
r_d(abs(r_d) <= cut) = 0; % if return is diffusive, set it to zero

end

