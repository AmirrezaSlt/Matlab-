function [P,T,ff,k]=bubble_P(zi,Tc,pc,w,bip,T,p_temp,k)
n=1;
x=zi;
y=k.*x;
ff=1.01;
[z_gas,ln_fi_gas]=ln_fi_cal(y,Tc,pc,w,bip,T,p_temp,'gas'); %#ok<*ASGLU>
[z_liq,ln_fi_liq]=ln_fi_cal(x,Tc,pc,w,bip,T,p_temp,'liq');
k=exp(ln_fi_liq)./exp(ln_fi_gas);
y=k.*x;
p_temp=p_temp*sum(y);
while abs(sum(y)-1)>1e-5
    [z_gas,ln_fi_gas]=ln_fi_cal(y,Tc,pc,w,bip,T,p_temp,'gas'); %#ok<*ASGLU>
    [z_liq,ln_fi_liq]=ln_fi_cal(x,Tc,pc,w,bip,T,p_temp,'liq');
    k=exp(ln_fi_liq)./exp(ln_fi_gas);
    y=k.*x;
    p_temp=p_temp*sum(y);
    n=n+1;
end
P=p_temp;
end