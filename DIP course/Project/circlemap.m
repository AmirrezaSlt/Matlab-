function o=circlemap(f,r)
[M,N]=size(f);
o=zeros(size(f));
for m=1:M
    for n=1:N
        for x=1:M
            for y=1:N
                t=(x-m)^2+(y-n)^2;
                if t==r^2;o(x,y)=o(x,y)+f(m,n);end
            end
        end
    end
end
% on=(o-min(min(o)))./(max(max(o))-min(min(o)));
end