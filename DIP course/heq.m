function o=heq(f)
    [M,N]=size(f);
    h=zeros(1,256);
    for m=1:M
        for n=1:N
            r=f(m,n);
            h(r+1)=h(r+1)+1;
        end
    end
    p=h/(M*N);
    cdf(1)=p(1);
    for k=2:256
        cdf(k)=p(k)+cdf(k-1);
    end
    for m=1:M
        for n=1:N
            r=f(m,n);
            o(m,n)=cdf(r+1);
        end
    end
end