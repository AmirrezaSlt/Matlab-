function [z,ln_fi]=ln_fi_cal(comp,Tc,pc,w,bip,T,p,str)
    R=10.73159;%psi*ft3/R/lbmole
    k_pure=0.3796+1.485.*w-0.1644*w.^2+0.01667*w.^3;
    Tr=T./Tc;%Tr for each component
%     str;
    bi=0.077796*R.*Tc./pc;%ft3/lbmole
    ai=0.457235*R^2*Tc.^2./pc.*(1+k_pure.*(1-sqrt(Tr))).^2;%psi.(ft3/lbmole)^2
    b=sum(comp.*bi);
    a=0;
    N=numel(comp);
    for i=1:N
        for j=1:N
            a=a+comp(i)*comp(j)*(1-bip(i,j))*sqrt(ai(i)*ai(j));
        end
    end
    A=a*p/R^2/T^2;
    B=b*p/R/T;
%     p
%     a*2.6829446252e-5
%     b*0.062372
%     A
%     B
    zarayeb=[1,B-1,A-2*B-3*B^2,B^3+B^2-A*B];
    z=roots(zarayeb);
    if strcmp(str,'gas')==1
        z=max(z(find(imag(z)==0))); %#ok<*FNDSB>
        if numel(z)>1
            z=z(1);
        end
    elseif strcmp(str,'liq')==1
        z=min(z(find(imag(z)==0)));
        if numel(z)>1
            z=z(1);
        end
    end
    ln_fi=zeros(N,1);
    for i=1:N
        const=sum(2*comp(:).*(1-bip(:,i)).*sqrt(ai(i).*ai(:)));
        ln_fi(i)=(bi(i)/b)*(z-1)-log(z-B)-A/(2*sqrt(2)*B)*(const/a-bi(i)/b)*log((z+B*(1+sqrt(2)))/(z+B*(1-sqrt(2))));
    end
end
  