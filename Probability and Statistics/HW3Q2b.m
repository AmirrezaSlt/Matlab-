clc
clear
close all
% Simulating of tossing a fair dice
% n = 120; % number of tosses
% max_error=3;
n=12000;
% for n=120:20000
Y=rand(1,n);
p=[0.5 1/6 1/6 1/18 1/18 1/18];
p=cumsum(p);
p=[0 p];
X=zeros([1,6]);
for i=1:6
    o=find(Y>p(i)&Y<p(i+1));
    X(i)=length(Y(o));
end
% minX = min(X);
% maxX = max(X);
% e = [minX:maxX+1]-0.5;
% H = histc (X,e);
% nbins = length (e) -1;
% bin_centers = [minX:maxX];
% bar(bin_centers, H(1:nbins),'w')
bar(X)
title(['Histogram of results after ',num2str(n),' throws']);
% d=diff(H);
% if abs(d)<max_error*ones(size(d))
%     break
% end
% close all
% end
% disp(['The minimum number of observations for Maximum ',num2str(max_error),...
%     ' Error(s) is : ',num2str(n)])