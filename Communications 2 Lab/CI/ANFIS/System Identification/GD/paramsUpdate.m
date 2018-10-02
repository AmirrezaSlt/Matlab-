function output=paramsUpdate(f,x_0_kp1,y_0_kp1,...
    params)

    global M;
    global n;

    x_0_kp1=reshape(x_0_kp1,1,n);
    
    sigma=reshape(params(1:M*n),M,n);
    xBar=reshape(params(M*n+1:2*M*n),M,n);
    yBar=reshape(params(2*M*n+1:end),M,1);
    
    for l=1:M
       for ii=1:n
           
       end
    end
    
    output=zeros(2*M*n+M,1);
    output(1:M*n)=reshape(sigma,M*n,1);
    output(M*n+1:2*M*n)=reshape(xBar,M*n,1);
    output(2*M*n+1:end)=reshape(yBar,M,1);

end