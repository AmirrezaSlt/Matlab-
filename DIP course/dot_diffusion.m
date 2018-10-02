function dot_diffusion = dot_diffusion(f)
[M,N]=size(f);
dot_diffusion=zeros(M,N);
c=[59,12,46,60,28,14,32,3;21,25,44,11,58,45,43,30;24,20,13,42,33,5,54,8;64,52,55,40,63,47,7,18;35,57,9,15,50,48,4,36;41,17,6,61,22,49,62,34;2,53,19,56,39,23,26,51;16,37,1,31,29,27,38,10];
m=1;
for x=1:8:M-7
    n=1;
    for y=1:8:N-7
        c2=zeros(3, 3);
        for k=1:64
            [row, col]=find(k);
            c2(1,1)=c(row,col)>c(row+1,col+1);
            c2(1,3)=c(row,col+2)>c(row+1,col+1);
            c2(3,1)=c(row+2,col)>c(row+1,col+1);
            c2(3,3)=c(row+2,col+2)>c(row+1,col+1);
            c2(1,2)=2*(c(row,col+1)>c(row+1,col+1));
            c2(2,1)=2*(c(row+1,col)>c(row+1,col+1));
            c2(2,3)=2*(c(row+1,col+2)>c(row+1,col+1));
            c2(3,2)=2*(c(row,col+1)>c(row+1,col+1));
            w=sum(sum(c2));
            dot_diffusion(m-1:m+1,n-1:n+1)=c2.*f(x-1:x+1,y-1:y+1)/w;
        end
        n=n+1;
    end
    m=m+1;
end

end

