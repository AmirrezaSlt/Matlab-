clc
clear
close all
d=0.25*[0 2;3 1];
disp('size=4 :')
N2dither(4,d)
disp('size=8 :')
N2dither(8,d)
f0=1/50;
f=zeros(250,250);
for x=1:250
    for y=1:250
        r=sqrt((x-125)^2+(y-125)^2); % Circle Equation
        r=mod(r,50);
        f(x,y)=ceil(r);
    end
end
figure,imshow(f,[]),title('Generated Image')
[M,N]=size(f);
fmax=max(max(f));
fmin=min(min(f));
for m=1:M
    for n=1:N
        f(m,n)=(1/(fmax-fmin))*(f(m,n)-fmin);
    end
end
d2=0.25*[1 0;1 1];
for i=1:2:249
    for j=1:2:249
        fd2(i:i+1,j:j+1)=d<=f(i:i+1,j:j+1);
    end
end
for i=1:4:247
    for j=1:4:247
        fd4(i:i+3,j:j+3)=N2dither(4,d)<=f(i:i+3,j:j+3);
    end
end
for i=1:8:243
    for j=1:8:243
        fd8(i:i+7,j:j+7)=N2dither(8,d)<=f(i:i+7,j:j+7);
    end
end
figure,imshow(fd2,[]),title('2D Ordered Dither with D=[0,2;3,1]')
figure,imshow(fd4,[]),title('4D Ordered Dither with D=[0,2;3,1]')
figure,imshow(fd8,[]),title('8D Ordered Dither with D=[0,2;3,1]')
for i=1:2:249
    for j=1:2:249
        f2d2(i:i+1,j:j+1)=d2<=f(i:i+1,j:j+1);
    end
end
for i=1:4:247
    for j=1:4:247
        f2d4(i:i+3,j:j+3)=N2dither(4,d2)<=f(i:i+3,j:j+3);
    end
end
for i=1:8:243
    for j=1:8:243
        f2d8(i:i+7,j:j+7)=N2dither(8,d2)<=f(i:i+7, j:j+7);
    end
end
figure,imshow(f2d2,[]),title('2D Ordered Dither with D=[1,0;1,1]')
figure,imshow(f2d4,[]),title('4D Ordered Dither with D=[1,0;1,1]')
figure,imshow(f2d8,[]),title('8D Ordered Dither with D=[1,0;1,1]')
T=0.5; 
c=f>=T;
e=c-f;
[M,N] = size(f);
for m=2:(M-1)
    for n=2:(N-1)
        c(m,n)=f(m,n)>=T;
        e(m,n)=c(m,n)-f(m,n);
        f(m-1,n+1)=f(m-1,n+1)-(e(m,n)*3/16);
        f(m,n+1)=f(m,n+1)-(e(m,n)*5/16);
        f(m+1,n+1)=f(m+1,n+1)-(e(m,n)*1/16);
        f(m+1,n)=f(m+1,n)-(e(m,n)*7/16);
    end
end
figure,imshow(c,[]),title('Error Diffused Image');
C=[59 12 46 60 28 14 32 3;21 25 44 11 58 45 43 30;24 20 13 42 33 5 54 8;...
64 52 55 40 63 47 7 18;35 57 9 15 50 48 4 36;41 17 6 61 22 49 62 34;...
2 53 19 56 39 23 26 51;16 37 1 31 29 27 38 10];
h=zeros(10);
h(2:9,2:9)=C;
for i=1:64
    u(:,:,i)=double(h(fix((i-1)/8)+1:fix((i-1)/8)+3,mod(i-1,8)+1:...
    mod(i-1,8)+3)>h(fix((i-1)/8)+2,mod(i-1,8)+2));
    u(:,:,i)=u(:,:,i).*[1 2 1 ; 2 2 2 ; 1 2 1];
    if sum(sum(u(:,:,i)))
        u(:,:,i)=u(:,:,i)/sum(sum(u(:,:,i)));
    end
end
for i=1:64
o(i)=find(C==i);
end
[M,N]=size(f);
for m=0:fix(M/8)-1
    for n=0:fix(N/8)-1
        for i=1:64
        f(8*m+1+fix((o(i)-1)/8),8*n+1+mod(o(i)-1,8)) =...
        f(8*m+1+fix((o(i)-1)/8),8*n+1+mod(o(i)-1,8)) >= T;
        e=f(8*m+1+fix((o(i)-1)/8),8*n+1+mod(o(i)-1,8)) -...
        f(8*m+1+fix((o(i)-1)/8),8*n+1+mod(o(i)-1,8));
        h=e*u(:,:,i);
            if ((8*m+1 + fix((o(i)-1)/8))~=1)&&((8*m+1 +fix((o(i)-1)/8))~=M)
                if (8*n+1 + mod(o(i)-1,8)~=1)&&(8*n+1 +mod(o(i)-1,8) ~= N)
                    f(8*m + fix((o(i)-1)/8):8*m+2+fix((o(i)-...
                    1)/8), 8*n + mod(o(i)-1,8):8*n+2 + mod(o(i)-1,8))=f(8*m +...
                    fix((o(i)-1)/8):8*m+2+fix((o(i)-1)/8),8*n+mod(o(i)-1,8)...
                    :8*n+2 + mod(o(i)-1,8))+h;
                end
            end
        end
    end
end
figure,imshow(f,[]),title('Dot Diffused Image');
function d=N2dither(n,d)
   x=log2(n);
   if x~=1
     for i=2:x
         k=4*(i^2);
         d=(1/k)*[k*d,k*d+2;k*d+3,k*d+1];
     end
   end 
end


