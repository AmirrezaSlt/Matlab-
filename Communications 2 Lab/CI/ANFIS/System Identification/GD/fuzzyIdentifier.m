function output=fuzzyIdentifier(x_0_kp1,y_0_kp1,...
    params)

    global M;
    global n;
    
    x_0_kp1=reshape(x_0_kp1,1,n);
    
    sigma=reshape(params(1:M*n),M,n);
    xBar=reshape(params(M*n+1:2*M*n),M,n);
    yBar=reshape(params(2*M*n+1:end),M,1);
    
    alpha=0.1;
    
    for q=1:10
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
    
    output=zeros(1+2*M*n+M,1);
    output(1:M*n)=reshape(sigma,M*n,1);
    output(M*n+1:2*M*n)=reshape(xBar,M*n,1);
    output(2*M*n+1:end-1)=reshape(yBar,M,1);    
    output(end)=y_hat_kp1;

end