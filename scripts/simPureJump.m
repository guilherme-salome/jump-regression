function [J,jump_location] = simPureJump(lambda,sigma,T,n)
% simPureJump simulates a pure jump process based on the compound poisson
%
% INPUT:
% lambda: number of expected jumps in the same unit as T, i.e., if T is
%         1.25 years (or 315 days), then lambda is the number of jumps per 
%         year, like 15/252;
% sigma: a number, daily standard deviation of the price process
% T: a number, like the total number of days
% n: a number, like the total number of returns in a day
% 
% OUTPUT:
% J: a n*Tx1 vector containing the accumulated jumps
%

nj = poissrnd(lambda*T); % number of jumps
sigma_jump = 5*sigma/sqrt(n); % std. dev. of jumps

jumps = normrnd(0,sigma_jump,nj,1);
jump_location = sort(floor(unifrnd(1,n*T,nj,1)));

J = zeros(n*T,1);
J(jump_location) = jumps;

for i = 2:n*T
    J(i) = J(i) + J(i-1);
end

end

