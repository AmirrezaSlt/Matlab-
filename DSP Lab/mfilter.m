function y=mfilter(p,a,b)
n=0.5*(a+b);
ca=(a-1)/2;
cb=(b-1)/2;
w=padarray(p,[ca,cb]);
[M,N]=size(w);
    for i=ca+1:M-ca
        for j=cb+1:N-cb
        h=w(i-ca:i+ca,j-cb:j+cb);
        h1=h(:);
        hs=sort(h1);
        y(i-ca,j-ca)=hs(n);
        end
    end
end

