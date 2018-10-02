clc
clear
close all
k=2;
x=0:0.1:10;
c=1;
for a=[1,1.5,2,2.5]
    y1=x./(1+abs((x/k).^(a+1)));
%     y2=x.*exp(-(x/k).^(a+1));
    y2=Db(x,k,a);
    subplot(4,2,c)
    plot(x,y1)
    c=c+1;
    subplot(4,2,c)
    plot(x,y2)
    c=c+1;
    suptitle('k=2 and \alpha=[1 1.5 2 2.5] for each row')
end
x=[zeros(5,1);ones(12,1);zeros(2,1)];
for k=1:4
    X(:,k)=2^k*x;
end
X=X(:);
I=[X',fliplr(X')];
figure,plot(I),axis([0,length(I),0,20]),title('I')
I1=I;I2=I;
L=length(I);
dx=1;k=2;a=1;kk=0.25;
c=1;
figure
for iteration=1:15000
    for n=dx+1:L-dx
        di1=I1(n+dx)-I1(n);
        di2=I1(n-dx)-I1(n);
        I1(n)=I1(n)+kk*Da(di1,k,a)+kk*Da(di2,k,a);
        di3=I2(n+dx)-I2(n);
        di4=I2(n-dx)-I2(n);
        I2(n)=I2(n)+kk*Db(di3,k,a)+kk*Db(di4,k,a);
    end
    if iteration==50||iteration==150||iteration==1500||iteration==15000
        subplot(4,2,c)
        plot(I1),axis([0,length(I),0,20]),title(['Diffused I with Da in iteration='...
        ,num2str(iteration)])
        c=c+1;
        subplot(4,2,c)
        plot(I2),axis([0,length(I),0,20]),title(['Diffused I with Db in iteration='...
        ,num2str(iteration)])
        c=c+1;
    end
end
% figure,plot(I1),axis([0,length(I),0,20]),title('Diffused I with Da')
% figure,plot(I2),axis([0,length(I),0,20]),title('Diffused I with Db')
A=ones(200)*50;
A(20:70,20:70)=54;
A(20:70,120:170)=58;
A(120:170,20:70)=64;
A(120:170,120:170)=80;
A(1:0)=0;
figure,imshow(A,[]),title('A')
dx=1;dy=1;
[M,N]=size(A);
A1=A;A2=A;
c=1;
for iteration=400
    for x=1+dx:M-dx
        for y=1+dy:N-dy
            d1=A1(x-1,y+1)-A1(x,y);
            d2=A1(x,y+1)-A1(x,y);
            d3=A1(x+1,y+1)-A1(x,y);
            d4=A1(x-1,y)-A1(x,y);
            d5=A1(x+1,y)-A1(x,y);
            d6=A1(x-1,y-1)-A1(x,y);
            d7=A1(x,y-1)-A1(x,y);
            d8=A1(x+1,y-1)-A1(x,y);
            dd1=A2(x-1,y+1)-A2(x,y);
            dd2=A2(x,y+1)-A2(x,y);
            dd3=A2(x+1,y+1)-A2(x,y);
            dd4=A2(x-1,y)-A2(x,y);
            dd5=A2(x+1,y)-A2(x,y);
            dd6=A2(x-1,y-1)-A2(x,y);
            dd7=A2(x,y-1)-A2(x,y);
            dd8=A2(x+1,y-1)-A2(x,y);
            A1=A1+kk*(Da(d1,k,a)+Da(d2,k,a)+Da(d3,k,a)+Da(d4,k,a)+...
            Da(d5,k,a)+Da(d6,k,a)+Da(d7,k,a)+Da(d8,k,a));
            A2=A2+kk*(Db(dd1,k,a)+Db(dd2,k,a)+Db(dd3,k,a)+Db(dd4,k,a)+...
            Db(dd5,k,a)+Db(dd6,k,a)+Db(dd7,k,a)+Db(dd8,k,a));
        end
    end
end
figure,imshow(A1,[]),title('Diffused A with Da')
figure,imshow(A2),title('Diffused B with Db')
An=A+4*randn(200);
figure,imshow(An,[]),title('Noisy A')
k=10;
for iteration=40000
    for x=1+dx:M-dx
        for y=1+dy:N-dy
            d1=An(x-1,y+1)-An(x,y);
            d2=An(x,y+1)-An(x,y);
            d3=An(x+1,y+1)-An(x,y);
            d4=An(x-1,y)-An(x,y);
            d5=An(x+1,y)-An(x,y);
            d6=An(x-1,y-1)-An(x,y);
            d7=An(x,y-1)-An(x,y);
            d8=An(x+1,y-1)-An(x,y);
            An=An+kk*(Db(d1,k,a)+Db(d2,k,a)+Db(d3,k,a)+Db(d4,k,a)+...
            Db(d5,k,a)+Db(d6,k,a)+Db(d7,k,a)+Db(d8,k,a));
        end
    end
end
figure,imshow(An,[]),title('Denoised A')
function o=Da(di,k,alpha)
o=di/(1+abs((di/k).^(alpha+1)));
end
function o=Db(di,k,alpha)
o=di.*exp(-(abs(di/k)).^(alpha+1));
end