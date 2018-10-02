clc
clear
close all
f=imread('lg-image26.jpg');
f=rgb2gray(f);
g=imresize(f,0.3);
figure,imshow(f,[]),title('Original Image')
figure,imshow(g,[]),title('Scaled Image')
gd=im2double(g);
[M,N]=size(g);
gamma=-10;
fgamma=255^(1-gamma)*gd.^gamma;
figure,imshow(fgamma,[]),title(['Gamma Corrected Image with Gamma=',num2str(gamma)])
 h=zeros(256,1);
for m=1:M
    for n=1:N
        r=g(m,n);
        h(r+1)=h(r+1)+1;
    end
end
s=h./(M*N); 
gh=heq(g);
figure,imshow(gh,[]),title('Histogram Equalizer')
T=0;
for i=1:256
    T=T+s(i)*(i-1);
end
% gh=zeros(M,N);
% gl=zeros(M,N);
% for m=1:M
%     for n=1:N
%         if g(m,n)>T;gh(m,n)=1;end
%         if g(m,n)<=T;gl(m,n)=1;end
%     end
% end
cdf(1)=h(1);
for i=2:256
    cdf(i)=h(i)+cdf(i-1);
end
figure,bar(cdf),title('CDF of the histogram')
hshift=max(h(1:floor(T)));
cdf(floor(T)+1:end)=cdf(floor(T)+1:end)+hshift;
gbh=zeros(size(g));
for m=1:M
    for n=1:N
        v=g(m,n);
        gbh(m,n)=cdf(v);
    end
end
figure,imshow(gbh,[]),title('Bihistogram Equalized Image')
% function o=bh(f)
%     
% end
% hh=zeros(256,1);
% hl=zeros(256,1);
% for m=1:M
%     for n=1:N
%         rh=gh(m,n);
%         hh(rh+1)=hh(rh+1)+1;
%         rl=gl(m,n);
%         hl(rl+1)=h(rl+1)+1;
%     end
% end
% for i=1:M
%     for j=1:N
%         gh2(i,j)=floor(255*sum(hh(1:gh(i,j))));
%         gl2(i,j)=floor(255*sum(hl(1:gl(i,j))));
%     end
% end
% gt=gh2+gl2;
% figure,imshow(gt,[])

 
L=30;
gzp(1:L,L+1:L+N)=g(1:L , :);
gzp((M+L+1):(M+2*L),L+1:L+N)=g((M-L+1):M,:);
gzp(L+1:L+M,1:L)=g(:,1:L);
gzp(L+1:L+M,(N+L+1):(N+2*L))=g(:,(N-L+1):N);
gzp(L+1:M+L,L+1:N+L)=g;
for m=L+1:M+L
    for n=L+1:N+L
        W=gzp(m-L:m+L,n-L:n+L);
        hw=zeros(256,1);
        for i=1:2*L+1
            for j=1:2*L+1
                r=W(i,j);
                hw(r+1)=hw(r+1)+1;
            end
        end
        hw=hw/(2*L+1)^2;
        r=gzp(m,n);
        CDF_r=sum(hw(1:r+1));
        gleq(m-L,n-L)=CDF_r;
    end
end
figure,imshow(gleq,[]),title('Local Histogram Equalization')
function gh=heq(g)
    [M,N]=size(g);
    h=zeros(256,1);
    for m=1:M
        for n=1:N
            r=g(m,n);
            h(r+1)=h(r+1)+1;
        end
    end
    for i=1:M
        for j=1:N
            gh(i,j)=floor(sum(h(1:g(i,j))));
        end
    end
end