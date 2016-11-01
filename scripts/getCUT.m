function cut = getCUT(alpha,TOD,BV,delta_n)
% getCUT calculates the jump cuts for a series of returns, returns above
%        the cut are classified as jump returns, returns below are 
%        diffusive returns
%
% INPUT
% alpha: number, number of standard deviations to use as a treshold
% TOD: nx1 vector; time of day factor that adjusts for changing volatility 
% throughout the day
% BV: Tx1 vector of bipower variances, where T is the number of days
% n: number of returns in a day
% delta_n: 1/n; size of intervals between samples
%
% OUTPUT
% cut: n*Tx1 vector of numbers
%

cut = alpha*(delta_n^0.49)*sqrt(kron(BV,TOD));

end

