%% Clear workspace
addpath('scripts/'); % path to scripts
clearWorkspace;

%% Parameters
mu = 0; % drift
sigma = 0.011; % non-stochastic volatility
n = 78; % number of PRICES per day, 78 = 5-min. prices
T = 248; % number of days, 252 days = 1 year
X0 = log(67); % starting price
lambda = 15/252; % number of jumps per yearr

%% Simulate Prices
X = simGeoPrice(mu,sigma,n,T,X0); % simulates X = 100*log(P)
[J,jump_location] = simPureJump(lambda,sigma,T,n); % simulates jumps in X

%% Get SPY price data
filename = 'data/SPY_5min.dat';
tkr = 'SPY';
raw_full = load(filename);
index = find(raw_full(:,1) == 20071231, 1, 'last' );
raw = raw_full(1:index,:);

%% Create Fake Stock Data
stkr = 'MS';
sraw = raw;
sraw(:,3) = exp(X+J);

%% Plot
plotPrice;
% print('-dpng','-r200',['figures/price' stkr '-' tkr '-Sim2007']); % save as png