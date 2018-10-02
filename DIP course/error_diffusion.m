function errd=error_diffusion(f)
    [M,N]=size(f);
    e=zeros(M,N);
    for m=1:M
        for n=1:N
            if (f(m,n)+e(m,n))<128
                errd(m,n)=0;
            else
                errd(m,n)=255;
            end
            e2 =(f(m,n)+e(m,n))-errd(m,n);
            if n<N
                e(m,n+1)=e(m,n+1)+e2*7/16;
            end
            if m<M
                e(m+1,n)=e(m+1,n)+e2*5/16;
                if n>1
                    e(m+1,n-1)=e(m+1,n-1)+e2*3/16;
                end
                if n<N
                    e(m+1,n+1)=e(m+1,n+1)+e2*1/16;
                end
            end
        end
    end
end

