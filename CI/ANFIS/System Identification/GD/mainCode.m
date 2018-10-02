clc;
close all

endTime=100;
stepTime=0.01;

M=4;
n=5;
alpha=0.5;

sigma=1*ones(M,n);
xBar=1*rand(M,n);
yBar=1*rand(M,1);



t=0:stepTime:endTime;
yPlant=zeros(size(t,2),1);
yEstimated=zeros(size(t,2),1);

tempPlot=zeros(size(t,2),1);

% uPlant=2+2*rand(size(t))';%sin(2*pi*t');
uPlant=sin(2*pi*t');
k=3;
for t=k*stepTime:stepTime:endTime
    yPlant(k+1)=myPlant(yPlant(k),yPlant(k-1),yPlant(k-2),uPlant(k),uPlant(k-1));
    
    x_0_kp1=[yPlant(k);yPlant(k-1);yPlant(k-2);uPlant(k);uPlant(k-1)];
    y_0_kp1=yPlant(k+1);
    
    for q=1:6
        b=0;
        a=0;
        z=ones(M,1);
        for l=1:M            
            for ii=1:n
                z(l)=z(l)*exp(-1*(((x_0_kp1(ii)-xBar(l,ii))/(sigma(l,ii)))^2));
            end
            b=b+z(l);
            a=a+yBar(l,1)*z(l);
        end

        y_hat_kp1=a/b;
        f=y_hat_kp1;
        
        for l=1:M
           for ii=1:n
                xBar(l,ii)=xBar(l,ii)-alpha*((f-y_0_kp1)/b)*...
                    ((yBar(l)-f)*z(l))*...
                    (2*(x_0_kp1(ii)-xBar(l,ii))/(sigma(l,ii)^2));
                
                sigma(l,ii)=sigma(l,ii)-alpha*((f-y_0_kp1)/b)*...
                    ((yBar(l)-f)*z(l))*...
                    (2*((x_0_kp1(ii)-xBar(l,ii))^2)/(sigma(l,ii)^3));
           end
           yBar(l,1)=yBar(l,1)-alpha*(f-y_0_kp1)*z(l)/b;
        end        
        
    end
    
%     sigma
    tempPlot(k+1)=xBar(1,1);
    
    yEstimated(k+1)=y_hat_kp1;
    k=k+1;
end

t=0:stepTime:endTime;
plot(t,yPlant);
hold on;
plot(t,1.0*yEstimated,'r');

figure
plot(t,tempPlot);