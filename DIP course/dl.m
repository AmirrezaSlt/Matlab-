clc
clear 
close all
f=imread('bloodcells1.jpg');
f=rgb2gray(f);
M=size(f,1);
N=size(f,2);
h=zeros(1,256);
for m=1:M
    for n=1:N
        v=f(m,n);
        h(v+1)=h(v+1)+1;
    end
end
p=h/(M*N);
f=255*im2double(f);
T=91;
M=size(f,1);
N=size(f,2);
g=zeros(size(f));
for m=1:M
    for n=1:N
        if f(m,n)>=T
            g(m,n)=1;
        end
    end
end
figure,imshow(g,[])
for iteration=1:100
  p1=h(1:T+1)./sum(h(1:T+1));
  u1=(0:T)*p1';
  p2=h(T+2:256)./sum(h(T+2:256));
  u2=(T+1:255)*p2';
  Teq=(u1+u2)/2;
  if abs(T-Teq)<1e-6
      break
  end
  T=Teq;
end
for m=1:M
    for n=1:N
        if f(m,n)>=T
            g(m,n)=1;
        end
    end
end
figure,imshow(g,[])
clear T
for T=1:253
    p1=sum(p(1:T+1));
    u1=[0:T]*(h(1:T+1)/sum(h(1:T+1)))';
    p2=sum(p(T+2:256));
    u2=[T+1:255]*(h(T+2:256)/sum(h(T+2:256)))';
    zig1=sum(((0:T)-u1).^2)*p1;
    zig2=sum(((T+1:255)-u2).^2)*p2;
    e(T)=zig1*sum(p(1:T+1))+zig2*sum(p(T+2:256));
end

idx=min(e(T));
T_otsu=find(idx);
for m=1:M
    for n=1:N
        g2(m,n) = f(m,n) >= T_otsu;
    end 
end
figure,imshow(g2,[])