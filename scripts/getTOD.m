function tod = getTOD(ret,n,T)
% getTOD calculates the Time of Day factor from returns
%
% INPUT
% ret: n*Tx1 vector of returns, assuming there are n returns in a day, and
%      T days of data
% n: number of returns observed in a day
% T: number of days
%
% OUTPUT
% tod: nx1 vector of time of day factors
%


b = zeros(n,1);

for i = 2:n
    idA = i:n:(T-1)*n+i;
    idB = idA - 1;
    b(i) = mean(abs(ret(idA).*ret(idB)));
end
b(1) = b(2);

tod = b/((1/n)*sum(b));

end

