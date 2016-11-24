function X = simGeoPrice(mu,sigma,n,T,X0)
% simGeoPrice simulates geometric stock prices (log price) according to a
%             constant coefficients gaussian diffusion process
% 
% INPUT
% mu: a number, coefficient for the drift
% sigma: a number, coefficient for the gaussian diffusion; standard
%        deviation should be in the same units as T, i.e., 0.011 std. dev. 
%        per day
% n: number of PRICES observed each day
% T: number of days
% X0: initial log-price of the stock
%
% OUTPUT
% X: n*Tx1 vector of simulated log-prices; to obtain regular prices just
%    exponentiate the vector
%

X = zeros(n*T,1);
delta = 1/n;
sqdelta = sqrt(delta);

x = X0;

for i = 1:n*T
   x = x + mu*delta + sigma*sqdelta*randn(1,1);
   X(i) = x;
end


end

