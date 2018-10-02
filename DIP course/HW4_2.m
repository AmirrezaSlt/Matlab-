clc
clear
close all
im1=imread('1832897_orig.png');
im1=rgb2gray(im1);
im1=255*im2double(im1);
figure;imshow(im1,[]);
title('Original Image');
im1=imresize(im1,0.16);
figure;imshow(im1,[]);
title('Small Scale Image');
h=[0 0 7/16;3/16 5/16 1/16];
[M1,N1]=size(im1);
fmax=max(max(im1));
fmin=min(min(im1));
g=zeros(M1,N1);
for m=1:M1
    for n=1:N1
        g(m,n)=(1/(fmax-fmin))*(im1(m,n)-fmin);
    end
end
im1b=ones(M1,N1);
e=zeros(M1,N1);
for m=1:M1-1
    for n=2:N1-1
        if g(m,n)<=0.5
            im1b(m,n)=0;
        end
        e(m,n)=im1b(m,n)-g(m,n) ;
        for i=1:2
            for k=1:3
                g(i+m-1,k+n-2)=g(i+m-1,k+n-2)-e(m,n)*h(i,k);
            end
        end
    end
end
figure,imshow(im1b,[]);
title('Error Diffused Image');
imc=imread('shutterstock_291431081.jpg');
imc=rgb2gray(imc);
imc=255*im2double(imc);
figure,imshow(imc,[])
title('Cover Image');
[M2,N2]=size(imc);
f21=bitget(imc,1);
B=padarray(im1b,[M2-M1 N2-N1],'post');
imc=bitset(imc,1,B);
f21=bitget(imc,1);
x=1:20;
N=length(x);
for k=1:N
    for n=1:N
        if k==1
            W(n,k)=sqrt(1/N);
        else
            W(n,k)=sqrt(2/N)*cos(pi*(k-1)*((2*n-1)/(2*N)));
        end
    end
end
W1=x*W;
W2=dct(x);
L=8;
for U=1:L
    for x=1:L
        A(U,x)=cos(pi*(U-1)*(2*x-1)/(2*L));
    end
end
B=zeros(8,8);
for U=1:L
    for V=1:L
        B(U,V)=cos(pi*(U-1)*(2*V-1)/(2*L));
    end
end
for i=1:8
    for j=1:8
        kl(:,:,i,j)=A(i,:)'*B(j,:);
    end
end
for m=1:8:M2-8
    for n=1:8:N2-8
        for i=1:8
            for j=1:8
                if i==1&&j==1
                X(i+m-1,j+n-1)=sum(sum((1/8)*imc(m:m+L-1,n:n+L-1).*kl(:,:,i,j)));
                elseif i==1&&j~=1
                X(i+m-1,j+n-1)=sum(sum((sqrt(2)/8)*imc(m:m+L-1,n:n+L-1).*kl(:,:,i,j)));
                elseif i~=1&&j==1
                X(i+m-1,j+n-1)=sum(sum((sqrt(2)/8)*imc(m:m+L-1,n:n+L-1).*kl(:,:,i,j)));
                else
                X(i+m-1,j+n-1)=sum(sum((2/8)*imc(m:m+L-1,n:n+L-1).*kl(:,:,i,j)));
                end
            end
        end
    end
end
for m=1:M1
    for n=1:N1
        if im1b(m,n)==0
        if X(2+L*(m-1),4+L*(n-1))<X(3+L*(m-1),1+L*(n-1))
        else
        c = X(2+L*(m-1),4+L*(n-1));
        X(2+L*(m-1),4+L*(n-1))=X(3+L*(m-1),1+L*(n-1));
        X(3+L*(m-1),1+L*(n-1))=c;
        end
        end
        if im1b(m,n)==1
        if X(2+L*(m-1),4+L*(n-1))>=X(3+L*(m-1),1+L*(n-1))
        else
        c = X(2+L*(m-1),4+L*(n-1));
        X(2+L*(m-1),4+L*(n-1))=X(3+L*(m-1),1+L*(n-1));
        X(3+L*(m-1),1+L*(n-1))=c;
        end
        end
    end
end
for m=1:L
    for n=1:L
        for p=1:L
            AA(m,p)=cos((p-1)*pi*(2*m-1)/(2*L));
        end
        for q=1:L
            BB(n,q)=cos((q-1)*pi*(2*n-1)/(2*L));
        end
    ik(:,:,m,n)=AA(m,:)'*BB(n,:);
    end
end
p=(2/L)*ones(8,8);
p(1,1)=p(1,1)/2;
p(1,2:8)=p(1,2:8)/sqrt(2);
p(2:8,1)=p(2:8,1)/sqrt(2);
for i=1:8:M2-L
    for j=1:8:N2-L
        for m=1:L
            for n=1:L
                fcc(m+i-1,n+j-1)=sum(sum(p.*X(i:i+7,j:j+7).*ik(:,:,m,n)));
            end
        end
    end
end
figure,imshow(fcc,[]),title('Coded Cover Image');
for m=1:8:M2-8
    for n=1:8:N2-8
        for i=1:8
            for j=1:8
                if i==1&&j==1
                XX(i+m-1,j+n-1)=sum(sum((1/8)*fcc(m:m+L-1,n:n+L-1).*kl(:,:,i,j)));
                elseif i==1&&j~=1
                XX(i+m-1,j+n-1)=sum(sum((sqrt(2)/8)*fcc(m:m+L-1,n:n+L-1).*kl(:,:,i,j)));
                elseif i~=1&&j==1
                XX(i+m-1,j+n-1)=sum(sum((sqrt(2)/8)*fcc(m:m+L-1,n:n+L-1).*kl(:,:,i,j)));
                else
                XX(i+m-1,j+n-1)=sum(sum((2/8)*fcc(m:m+L-1,n:n+L-1).*kl(:,:,i,j)));
                end
            end
        end
    end
end
for m=1:M2/8-L
    for n=1:N2/8-L
        if XX(2+L*(m-1),4+L*(n-1))<XX(3+L*(m-1),1+L*(n-1))
        him(m,n)=0;
        else
        him(m,n)=1;
        end
    end
end
figure,imshow(him,[]),title('DCT Decoded Image');