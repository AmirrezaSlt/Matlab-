clc
clear
close all
% Simulating of tossing a fair dice
% n = 12000; % number of tosses
max_error=0.1;
for n=120:20000
X = ceil(6*rand(1,n));
% save to avoid recomputing min & max
minX = min(X);
maxX = max(X);
e = [minX:maxX+1]-0.5;
H = histc (X,e);
nbins = length (e) -1;
bin_centers = [minX:maxX];
bar(bin_centers, H(1:nbins),'w')
title(['Histogram of results for ',num2str(max_error*100),' percent '...
    ,'error rate was after ',num2str(n),' throws']);
H=H(1:nbins);
d=diff(H)/(n/6);
if max(abs(d))<max_error
    break
end
close all
end
disp(['The minimum number of observations for Maximum ',num2str(max_error),...
    ' Error(s) is : ',num2str(n)])