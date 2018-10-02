clc
clear
global index
RR=10.73159;%psi*ft3/R/lbmole
load('pure-properties of component.mat');%psi-ft3/lbmole-rankin
memory=cell(1,11);
memory{1}='CO2  ';memory{2}='N2  ';
memory{3}='C1  ';memory{4}='C2  ';
memory{5}='C3  ';memory{6}='i-C4';
memory{7}='C4  ';memory{8}='i-C5';
memory{9}='C5  ';memory{10}='C6  ';memory{11}='C7+ ';
print(memory);
fprintf('plz enter number of materials in your mixture like[1 2 3]\n for mixture of C1,C2,C3 :\n');
%index=input('');
index=(1:11)
N=numel(index);
fprintf('your components are:\n');
name=char(memory(index));
disp(name);
fprintf('enter composition of components in mixture respectively:   \n');
%zi=input('\n');
zi=[0.0008;0.0164;0.284;0.0716;0.1048;0.042;0.042;0.0191;0.0191;0.0405;0.3569];
%M_c7p=252;S_c7p=0.8429;
% pc_c7p=(8.191-2.97*log10(M_c7p-61.1)+(S_c7p-0.8)*(15.99-5.87*log10(M_c7p-53.7)));%Mpa----%eq3.58 danesh
% pc_c7p=pc_c7p*10*14.503774;%psi
%pc_c7p=252.3;
% Tc_c7p=338+202*log10(M_c7p-71.2)+(1361*log10(M_c7p)-2111)*log10(S_c7p);%kelvin eq3.57 danesh
% Tc_c7p=1.8*(338+202*log10(M_c7p-71.2)+(1361*log10(M_c7p)-2111)*log10(S_c7p))+50;%rankin eq3.57 danesh
%Tc_c7p=724*1.8;
%Vc_c7p=0.286*RR*Tc_c7p/pc_c7p;%ft3/lbmole
% Vc_c7p=13.4384;
%w_c7p=0.68;
w=pure_prop(:,4);
%w=[w;w_c7p];
% Vc=pure_prop(:,3)*1e-6;%m3/mole
Vc=pure_prop(:,3);%ft3/lbmole
%Vc=[Vc;Vc_c7p];%
pc=pure_prop(:,2);%bar
%pc=[pc;pc_c7p];
Tc=pure_prop(:,1);%kelvin
%Tc=[Tc;Tc_c7p];%K
%landa=zi.*Vc./sum(zi.*Vc);
%pc_avg=sum(zi.*pc);
%W=sum(zi.*w);
%Tpc=sum(landa.*Tc);%kelvin
%ppc=pc_avg*(1+(5.808+4.93*W)*(Tpc/sum(Tc.*zi)-1));%psi
%Tpc=Tpc;
Tpc=1195.3;ppc=1213.2;
% T=linspace(460,Tpc-10,100);%rankin
% T=T';
T_bubble=linspace(300,Tpc-5,100);
p_bubble=zeros(numel(T_bubble),1);
load('Binary-interaction-parameters.mat');
for i=1:numel(T_bubble)
    clc
    fprintf('%d%%\n',i/numel(T_bubble)*100)
    k_shortcut=1./zi;
    if i==1
        p_temp=pc(1)/k_shortcut(1)*exp(5.37*(1+w(1))*(1-Tc(1)./T_bubble(i)));
        k=pc./p_temp.*(exp(5.37*(1+w).*(1-Tc./T_bubble(i))));
    elseif i==2
        p_temp=p_bubble(i-1);
    else
        p_temp=(p_bubble(i-1)-p_bubble(i-2))/(T_bubble(i-1)-T_bubble(i-2))*(T_bubble(i)-T_bubble(i-1))+p_bubble(i-1);
    end
    [p_bubble(i),T_bubble(i),ff,k]=bubble_P(zi,Tc,pc,w,bip,T_bubble(i),p_temp,k);
end