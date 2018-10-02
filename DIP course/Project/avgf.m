function o=avgf(f,w)
o=zeros(size(f));
[M,N]=size(f);
L=(w-1)/2;
for m=1+L:M-L
    for n=1+L:N-L
        g=f(m-L:m+L,n-L:n+L);
        t=mean(mean(g));
        o(m-L:m+L,n-L:n+L)=t;
    end
end
end

