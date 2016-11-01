function [returns,serial_dates] = getReturnAndDate(DD,prices,n,T)
% getReturnFromRaw converts raw intraday data into intraday returns and
% dates
%
% INPUT 
% DD: is a nx3 matrix, it contains dates stored as numbers. 
%     The first column contains date in the format "yyyymmdd", the second
%     column contains time stored as "hhnn", and the third column stores
%     the seconds as "ss". The third column is optional, meaning DD could
%     be a nx2 matrix not containing seconds information.
% prices: a nx1 matrix containing intraday prices.
% n: a number representing the number of intraday returns in the
%    data. For example, if your data contains 78 observations for
%    each day, then  the number of returns that can be calculated
%    from them are 77. In this case, n should be 77.
% T: a number representing the number of periods observed in the data. For
%    example, if the data consists of intraday returns, then T is the number
%    of days for which you have intraday returns.
%
%
% OUTPUT 
% returns: a n*Tx1 vector containing the intraday returns
% serial_dates: a n*Tx1 vector containing the serial dates (Matlab
%               format) that correspond to the intraday returns

returns = zeros(n*T,1); % placeholder for returns
dates = zeros(n*T,2); % placeholder for dates

% Each day has n observations, resulting in n-1 returns. Each
% observation has a date, but we do not save the date of the first
% observation, since there is no return associated to it (we are only
% calculating intraday returns, we forget about the difference between
% the closing and opening of the market).
for t=1:T
    id = (t-1)*(n+1) + (1:1:(n+1))'; % [1,...,n+1],[n+2,...,2n+2],...
    idr = (t-1)*n +(1:1:n)'; % [1,...,n],[n+1,...,2n],...
    returns(idr) = 100*diff(log(prices(id,1))); % intra day returns: geometric returns
    if size(DD,2) == 2
        dates(idr,:) = DD(id(2:end),1:2); % skips the first date, because there is no return available for it
    elseif size(DD,2) == 3
        dates(idr,:) = DD(id(2:end),1:3); % if seconds are available, use them
    else
        error('DD should contain 2 or 3 columns');
    end
end

serial_dates = getSerialDate(dates);
end

