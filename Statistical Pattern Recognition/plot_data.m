% CAUTION: This function can handle up to
% six different classes
function plot_data(X,y,m)
[~,N]=size(X); % N=no. of data vectors, l=dimensionality
% [l,c]=size(m); % c=no. of classes
% if l~=2
%     fprintf('NO PLOT CAN BE GENERATED\n')
% return
% else
pale=['rx'; 'gx'; 'bx'; 'yx'; 'mx'; 'cx'];
figure
% Plot of the data vectors
hold on
for i=1:N
    plot(X(1,i),X(2,i),pale(y(i),:),'LineWidth',3)
end
% Plot of the class means
% for j=1:c
%     plot(m(1,j),m(2,j),'ko','LineWidth',1)
% end
end