%% Clear workspace
addpath('scripts/'); % path to scripts
clearWorkspace;

%% Separate data by year
past_index = 0;
for y = 2007:2015 % selects the year of the data
filename = 'data/SPY_5min.dat';
tkr = 'SPY';
raw_full = load(filename); % load the full sample data 

% find the last index of the year 'y'
index = find(raw_full(:,1) == str2num([num2str(y) num2str(1231)]), 1, 'last' );
if isempty(find(raw_full(:,1) == str2num([num2str(y) num2str(1231)]), 1, 'last' ))
    index = find(raw_full(:,1) == str2num([num2str(y) num2str(1230)]), 1, 'last' );
end

%% Parameters
n = 77; % returns per day
T = (index-past_index)/(n+1); % number of days
delta_n = 1/n;
alpha = 4; % used in the jump threshold
sig = 0.05; % significance level
kn = 11;
sim = 1000; % number of monte carlo simulations (used in CI and HT)

%% Load Data for SPY
raw = raw_full(past_index+1:index,:); % cut data to get only 1 year

%% SPY: Extract Returns, BV, TOD, Jump CUT, Diffusive Returns and Jump Returns
[ret,dates] = getReturnAndDate(raw(:,1:2),raw(:,3),n,T);
BV = getBV(ret,n,T); % bipower variance
tod = getTOD(ret,n,T); % time of day factor
cut = getCUT(alpha,tod,BV,delta_n); % jump threshold
[r_c,r_d] = separateReturns(ret,cut); % diffusive and jump returns

%% Change stocks at each iteration and save results
stocks = {'AIG','BLK','CB','C','GNTX','MET','MMC','MS','PNC','STT','TRV'}';
% results = struct();

for q = 1:length(stocks)
stkr = stocks{q};
sraw_full = load(['data/' stkr '_5min.dat']);
sraw = sraw_full(past_index+1:index,:); % cut data to get only 1 year

%% STOCK: Extract Returns, BV, TOD, Jump CUT, Diffusive Returns and Jump Returns
[sret,~] = getReturnAndDate(sraw(:,1:2),sraw(:,3),n,T);
sBV = getBV(sret,n,T);
stod = getTOD(sret,n,T);
scut = getCUT(alpha,stod,sBV,delta_n);
[sr_c,sr_d] = separateReturns(sret,scut);

%% Find Jump Location, Spot Covariances at Jumps and the Jump Beta
jump_loc = find(abs(ret) > cut);
[c,flag] = getSpotCov(sr_c,r_c,jump_loc,n,kn); % pre-jump and post-jump spot covariance matrices
Q = getJumpCov(sret,ret,jump_loc); % jump covariance matrix

nj = length(jump_loc); % number of jumps
[sigma,R] = getSpotVol(c,Q,nj);
[beta,beta_tilde] = jumpReg(sret,ret,Q,c,jump_loc,nj); % jump beta
[CI_low, CI_up] = jumpRegCI(beta,sig,ret,c,Q,jump_loc,nj,delta_n,sim); % confidence intervals

%% Hypothesis Testing
[cv,rho,zeta] = jumpRegHT(ret,jump_loc,c,Q,nj,sig,sim);
rej = 'not rejected';
if (1-rho^2) > (delta_n*cv/(Q(1,1)*Q(2,2))) 
    rej = 'rejected'; % if null-hypothesis is rejected
end
pval = sum((det(Q)/delta_n)<=zeta)/length(zeta);

%% Plot everything
plotPrice; % Plot stock and market price
print('-dpng','-r200',['figures/price' stkr '-' tkr '-' num2str(y)]); % save as png
plotJumpReg; % Plot stock returns against market jumps
print('-dpng','-r200',['figures/jumpreg' stkr '-' tkr '-' num2str(y)]); % save as png

%% Save Results
% results.(stkr) = struct();
% results.(stkr).beta = beta;
% results.(stkr).CI = [CI_low, CI_up];
% results.(stkr).cv = cv;
% results.(stkr).pval = pval;

disp('STEP');
end
disp(['DONE' num2str(y)]);
past_index = index; % update index
end