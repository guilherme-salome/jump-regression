function serial_date = getSerialDate(DD)
% serial_date converts dates and minutes into the Matlab serial date format
%
% INPUT 
% DD: is a nx3 matrix, it contains dates stored as numbers. 
%     The first column contains date in the format "yyyymmdd", the second
%     column contains time stored as "hhnn", and the third column stores
%     the seconds as "ss". The third column is optional, meaning DD could
%     be a nx2 matrix.
%
% OUTPUT 
% serial_date: is a vector of serial date numbers (Matlab format)
%

% Extract the year, month and day
yyyy = floor(DD(:,1)/10^4);
mm   = floor((DD(:,1) - 10^4*yyyy)/10^2);
dd   = DD(:,1) - yyyy*10^4 - mm*10^2;

% Extract the hour and minutes
hr = floor(DD(:,2) ./ 100);
nn = DD(:,2) - hr.*100;

% Extract the seconds
ss = 0; % if DD has no seconds data
if size(DD,2) == 3
    ss = DD(:,3);
end

serial_date = datenum(yyyy,mm,dd,hr,nn,ss); % transforms a date into a serial date number

end

