clc
clear
close all
fid=readtable('Iris-Data_dat.txt');
y=fid(:,1);
x=fid(:,2:5);
x=table2array(x);
y=table2array(y);
N=length(y);
yest=zeros(size(y));
for i=1:N
    % Removing one row from the dataset     
    if i==1
        xn=x(2:end,:);
        yn=y(2:end);
    elseif i==N
        xn=x(1:end-1,:);
        yn=y(1:end-1);
    else
        xn=[x(1:i-1,:);x(i+1:N,:)];
        yn=[y(1:i-1);y(i+1:N)]; 
    end
    % Acquiring mean and variance of the new data
    m(1,:)=mean(x(yn==1,:));
    var(1,:)=std(x(yn==1,:)).^2;
    m(2,:)=mean(x(yn==2,:));
    var(2,:)=std(x(yn==2,:)).^2;
    m(3,:)=mean(x(yn==3,:));
    var(3,:)=std(x(yn==3,:)).^2;
    % Performing bayesian classification
    gv=zeros(3,4);
    for j=1:3
        gv(j,:)=1./(var(j,:)).*exp(-0.5./var(j,:).*((x(i,:)-m(j,:)).^2));
    end
    [gv,idx]=max(gv);
        if length(find(idx==1))>=2
            yest(i)=1;
        elseif length(find(idx==2))>=2
            yest(i)=2;
        else
            yest(i)=3;
        end
end
pc=sum(y==yest)/length(y);
pe=1-pc;