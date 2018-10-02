function o=medf(f,w)
o=zeros(size(f));
[M,N]=size(f);
L=(w-1)/2;
for m=1+L:M-L
    for n=1+L:N-L
        g=f(m-L:m+L,n-L:n+L);
        t=sort(g(:))';
        k=t((w^2+1)/2);
        o(m-L:m+L,n-L:n+L)=k;
    end
end
end

