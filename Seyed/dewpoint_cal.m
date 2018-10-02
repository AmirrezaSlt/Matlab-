p_dew=linspace(25,p_bubble(end),100);
p_dew=p_dew';
T_dew=zeros(numel(p_dew),1);
load('Binary-interaction-parameters.mat');
for i=1:1:numel(T_dew)
    clc
    fprintf('%d%%\n',i/numel(T_dew)*100)
    k_shortcut=zi;
    if i==1
        T_temp=Tc(end)/(1-(log(p_dew(i)*k_shortcut(end)/pc(end)))/(5.37*(1+w(end))));
        k=pc./p_dew(i).*(exp(5.37*(1+w).*(1-Tc./T_temp)));
    elseif i==2
        T_temp=T_dew(i-1);
    else
        T_temp=(T_dew(i-1)-T_dew(i-2))/(p_dew(i-1)-p_dew(i-2))*(p_dew(i)-p_dew(i-1))+T_dew(i-1);
    end
    [p_dew(i),T_dew(i),ff,k]=dew_P(zi,Tc,pc,w,bip,T_temp,p_dew(i),k);
end