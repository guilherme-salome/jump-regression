function Q = getJumpCov(sret,ret,jump_loc)
% getJumpCov estimates the Jump Covariance matrix of a bivariate process
%
% INPUT
% sret: n*Tx1 vector of stock returns
% ret: n*Tx1 vector of market returns
% jump_loc: vector with the indices of the market return jumps
%
% OUTPUT
% Q: 2x2 matrix estimator of the Jump Covariance matrix
%
Q = zeros(2,2);
for i = 1:length(jump_loc)
    X = [ret(jump_loc(i)); sret(jump_loc(i))];
    Q = Q + X*X';
end

end

