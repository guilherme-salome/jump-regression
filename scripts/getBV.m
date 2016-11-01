function bipower_variance = getBV(returns,n,T)
% bipower_variance calculates the annualized bipower variance from the returns
%
% INPUT
% returns: vector of the intraday returns, excludes overnight returns
% n: number of returns in a day (example: if a day has 78 observations,
%    then it will have 77 returns)
% T: number of days
%
% OUTPUT
% bipower_variance: annualized bipower variance calculated as the sum of
%                   the intraday returns multiplied by their 1-lagged 
%                   values of a single day, then multiplied by 252, and 
%                   finally square rooted. 
%

bipower_variance = zeros(T,1); % one bipower variance per day
for t = 1:T
    bipower_variance(t,1) = ((pi/2)*(n/(n-1)))*sum(abs(returns((t-1)*n+2:t*n,1).*abs(returns((t-1)*n+1:t*n-1,1))));
end
end

