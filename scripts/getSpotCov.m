function [c,flag] = getSpotCov(sr_c,r_c,j_loc,n,kn)
% getSpotCov estimates the spot covariance matrix of a bivariate process,
%            without assuming the underlying variance process is 
%            continuous
%
% REFERENCE: equations 3.8 and 3.9
%
% INPUT
% sr_c: n*Tx1 vector of continuous returns of the stock
% r_c: n*Tx1 vector of continuous returns of the market
% j_loc: vector containing the indices of where the market return jumped
% n: number of returns in a day
% kn: size of the bandwidth used to calculate the local volatility
%
% OUTPUT
% c: a length(j_loc)x2 cell containing the approximations for the pre-jump
%    and the post-jump spot covariance matrices for each jump time
% flag: a length(j_loc)x1 vector containing 1 if the jump return locations
%       was at the beginning or end of the day, and 0 otherwise
%

c = cell(length(j_loc),2);
flag = zeros(length(j_loc),1);
    
for i = 1:length(j_loc)
    % check if jump is at the end or beginning of the day
    top = ceil(j_loc(i)/n)*n;
    bot = top-n+1;
    if (j_loc(i) + kn > top || j_loc(i) - kn < bot)
        flag(i) = 1;
    end

    c_minus = zeros(2,2);
    for j = 0:(kn-1)
        if (j_loc(i)-kn+j > length(sr_c)) || (j_loc(i)-kn+j < 1)
            break;
        end
        X = [r_c(j_loc(i)-kn+j);sr_c(j_loc(i)-kn+j)];
        c_minus = c_minus + X*X';
    end
    c{i,1} = c_minus*(n/kn);    
    
    c_plus = zeros(2,2);
    for j = 1:kn
        if (j_loc(i)+j > length(sr_c)) || (j_loc(i)+j < 1)
            break;
        end
        X = [r_c(j_loc(i)+j);sr_c(j_loc(i)+j)];
        c_plus = c_plus + X*X';
    end
    c{i,2} = c_plus*(n/kn);
end



end

