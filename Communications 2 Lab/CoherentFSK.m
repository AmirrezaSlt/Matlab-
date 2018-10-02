T = 1;delt = 0.01; 
ti = 0:delt:T-delt; 
A = input('Input A: '); 
u = input('Input a binary sequence of 5 characters (enter as a vector in brackets): '); 
fc = 5; 
delf = 1/T;   
r = []; 
out = []; 
for i = 1:5
    n = .2*randn(size(ti));      
    s1 = A*cos(2*pi*fc*ti);     
    s2 = A*cos(2*pi*(fc+delf)*ti);    
    if u(i) == 0
        ri = s1 +n;    
    else
        ri = s2 +n;
    end
    r1a = s1.*ri;    
    r2a = s2.*ri;    
    r1=0;r2=0;
    for k = 1:length(ti)-1      
        r1 = r1+r1a(k)*delt/2+r1a(k+1)*delt/2;       
        r2 = r2+r2a(k)*delt/2+r2a(k+1)*delt/2;    
    end
    r = [r ri];      
    if r1 >= r2       
    out=[out 0];    
    else
    out = [out 1];    
    end
end
out
ti = 4*T:delt:5*T-delt; 
t = 0:delt:5*T-delt; 
figure(1) 
subplot(211),plot(ti,r1a)   
ylabel('r1a') 
xlabel('Time') 
subplot(212)
plot(ti,r2a) 
ylabel('r2a') 
xlabel('Time')
figure(2) 
plot(t,r) 
title('Received signal') 
xlabel('Time (sec)')