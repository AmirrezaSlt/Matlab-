function [P,T_temp,ff,k]=dew_P(zi,Tc,pc,w,bip,T_temp,p,k)
n=1;
y=zi;
x=y./k;
ff=1.01;
[z_gas,ln_fi_gas]=ln_fi_cal(y,Tc,pc,w,bip,T_temp,p,'gas'); %#ok<*ASGLU>
[z_liq,ln_fi_liq]=ln_fi_cal(x,Tc,pc,w,bip,T_temp,p,'liq');
k=exp(ln_fi_liq)./exp(ln_fi_gas);
x=y./k;
if sum(x)>1
    T_temp=T_temp+0.01;
elseif sum(x)<1
    T_temp=T_temp-0.01;
end
while abs(sum(x)-1)>1e-4
    [z_gas,ln_fi_gas]=ln_fi_cal(y,Tc,pc,w,bip,T_temp,p,'gas'); %#ok<*ASGLU>
    [z_liq,ln_fi_liq]=ln_fi_cal(x,Tc,pc,w,bip,T_temp,p,'liq');
    k=exp(ln_fi_liq)./exp(ln_fi_gas);
    x=y./k;
    if sum(x)>1
        T_temp=T_temp+0.005;
    elseif sum(x)<1
        T_temp=T_temp-0.005;
    end
    n=n+1;
end
P=p;
end