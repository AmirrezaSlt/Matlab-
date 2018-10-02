clc
clear all
close all
%% 
f_co = imread('1.bmp');
f = rgb2gray(f_co);
figure;imshow(f,[]);title('Original image','FontWeight','bold');
% f = 255*im2double(f);
[M,N] = size(f);
h = imhist(f);figure;plot(h)
% t=0:255;
% figure ; plot(t,h,'-','linewidth',2); title('Histogram of Image '); 
% xlabel('Intensity'); ylabel('Number of Pixel'); xlim([0 255])
% f1=f;

% f=g2;
figure; imshow(f_co(:,:,1),[]);title('RED image','FontWeight','bold');
figure; imshow(f_co(:,:,2),[]);title('GREEN image','FontWeight','bold');
figure; imshow(f_co(:,:,3),[]);title('BLUE image','FontWeight','bold');
f=double(f_co(:,:,3));
%% Apply "Gamma Correction" Method 
gamma = 1.5;
g = 255^(1-gamma).*(double(f).^gamma);

figure ; imshow(g,[]); title(['Apply "Gamma Correction" with  \gamma = ' num2str(gamma) ]);
% fig = gcf;
% set(fig.Children,'FontName','Times','FontSize',20);
% set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))

%%%% Plot Histogram 
h1 = imhist(uint8(g));
t=0:255;
figure ; plot(t,h1,'-','linewidth',2); title(['Histogram of Image by Applying Gamma Correction \gamma= ' num2str(gamma)]); 
xlabel('Intensity'); ylabel('Number of Pixel'); xlim([0 255])
% fig = gcf;
% set(fig.Children,'FontName','Times','FontSize',20);
% set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
%% Produce Noisy A and Diffuse and Denoise it////////////////////////////
An=g;
dx=1;dy=1;a=1;
figure,imshow(An,[]),title('Noisy A','FontWeight','bold')
k=2;kk=0.125;
for iteration=1:30
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
            An(x,y)=An(x,y)+kk*(Db(d1,k,a)+Db(d2,k,a)+Db(d3,k,a)+Db(d4,k,a)+...
            Db(d5,k,a)+Db(d6,k,a)+Db(d7,k,a)+Db(d8,k,a));
        end
    end
end
figure,imshow(round(An),[]);
title(['Denoised A with k = ',num2str(kk),',K = ',num2str(k),...
    ',iteration = ',num2str(iteration)],'FontWeight','bold');
%% OTSU Method - Global
f=An;
f = imcrop(f,[63 17 190 190]);figure; imshow(f,[]);
[M,N]=size(f);
tic
p = h./numel(f); % Creat PDF function of histogram 
for T=1:254
    p1 = sum(p(1:T+1));
    p2 = sum(p(T+2:256));
    u1 = [0:T]*((h(1:T+1))/(sum(h(1:T+1))));
    u2 = [T+1:255]*((h(T+2:256))/(sum(h(T+2:256))));
    zigma1 = (([0:T]-u1).^2)*((h(1:T+1))/(sum(h(1:T+1))));
    zigma2 = (([T+1:255]-u2).^2)*((h(T+2:256))/(sum(h(T+2:256))));
    epsilon(T) = (zigma1*sum(p(1:T+1)))+(zigma2*sum(p(T+2:256)));
end 
OTSU = toc
T_new = find(epsilon == min(epsilon));
for m=1:M
    for n=1:N
        g2(m,n) = f(m,n) >= T_new;
    end 
end

figure ; imshow(g2); title(['Global Method - OTSU  T=' num2str(T_new) ]);

%%%% Plot Histogram with Threshold
figure ; hax = axes; 
plot(t,h,'-','linewidth',2); xlabel('Intensity')
line([T_new T_new],get(hax,'YLim'),'LineStyle','-.','Color',[1 0 0],'LineWidth',2.1)
legend('Histogram',['T =' num2str(T_new)])
%%%% Plot epsilon's values
figure ; hax = axes; 
t1=1:T;
plot(t1,epsilon,'-','linewidth',2); xlabel('Threshold (T)'); ylabel('Epsilon'); xlim([1 T]) 
line([T_new T_new],get(hax,'YLim'),'LineStyle','-.','Color',[1 0 0],'LineWidth',2.1)
legend('Epsilon Values',['T =' num2str(T_new)])
%% Canny////////////////////////
% f=g2;
gaussian = fspecial('gaussian',15,15/6);
f1=f;
f = imfilter(f,gaussian);
sobelx = fspecial('sobel'); sobely = sobelx';
dx = double(imfilter(f,sobelx));
dy = double(imfilter(f,sobely));
grad = sqrt(dx.^2 + dy.^2);
figure ; imshow(grad,[]);title('My Grad mag image','FontWeight','bold');
[Dx,Dy] = gradient(f);
grad_mag = sqrt(Dx.^2+Dy.^2);
figure ; imshow(grad_mag,[]);title('Matlabs grad mag image','FontWeight','bold');
teta = atan(dy./(dx+eps));
z = teta<0;
teta = teta+pi*z;
teta = teta*180/pi;
% % figure ; 
% % % contour(G,[0 0],'r')
% % % hold on ;
% % quiver(dx,dy);
% % colormap hsv;
%% teta quantizer/////////////
for x=1:M
    for y=1:N 
        if teta(x,y)<=22.5 teta(x,y)=0;
        elseif teta(x,y)>22.5 && teta(x,y)<=67.5 teta(x,y)=45; 
        elseif teta(x,y)>67.5 && teta(x,y)<=112.5 teta(x,y)=90;
        elseif teta(x,y)>112.5 && teta(x,y)<=157.5 teta(x,y)=135;
        elseif teta(x,y)>157.5 teta(x,y)=0;
        end
    end
end
%% Non Maximum Suppression block////////////////////
Mat=zeros(M,N);
% grad = grad_mag;
for m=2:M-1
    for n=2:N-1
        if teta(m,n)==0 && grad(m,n)>grad(m-1,n) && grad(m,n)>grad(m+1,n)
            Mat(m,n)=grad(m,n);
        elseif teta(m,n)==45 && grad(m,n)>grad(m-1,n-1) && grad(m,n)>grad(m+1,n+1)
            Mat(m,n)=grad(m,n);
        elseif teta(m,n)==90 && grad(m,n)>grad(m,n-1) && grad(m,n)>grad(m,n+1)
            Mat(m,n)=grad(m,n);
        elseif teta(m,n)==135 && grad(m,n)>grad(m-1,n+1) && grad(m,n)>grad(m+1,n-1)
            Mat(m,n)=grad(m,n);
        end
    end
end
figure; imshow(Mat,[]);title('Non Maximum Suppression in Canny Algorithm','FontWeight','bold');
%% High Threshold////////////////////
TH = 10;
R = Mat>TH;
figure; imshow(R,[]);title('High Threshold in Canny Algorithm','FontWeight','bold');
%% Low Threshold////////////////////
TL = 5;
for m=1:M-1
    for n=1:N-1
        if R(m,n)==1
            S = Mat(m-1:m+1,n-1:n+1);
            a = S>=TL;
            R(m-1:m+1,n-1:n+1) = a;
        end
    end
end
figure; imshow(R,[]);title('Low Threshold in Canny Algorithm','FontWeight','bold');
%% Level set//////////////////////////////
f=f1;
figure; imshow(f,[]);
[Dx,Dy] = gradient(f);
grad_mag = sqrt(Dx.^2 + Dy.^2);
G_M = 1+0.15*grad_mag;
p = 1./G_M;
p = double(p);
phi = ones(M,N);
phi(3:M-3,3:N-3)=-1;
figure;contour(phi,[0 0],'r');axis equal;
figure;mesh(phi);
% pause;
phi = double((phi>0).*(bwdist(phi<0)-0.5)-(phi<0).*(bwdist(phi>0)-0.5));
e=1.35;u=1;
for iter = 1:100
    phi = phi + e*p;
    g=zeros(M,N);
    figure(34);imshow(f,[]);hold on;
    contour(phi,[0 0],'r','LineWidth',2);
    title(['Number of iterations = ',num2str(iter)]);
    pause(0.1);
    F2(u)=getframe;
    u = u+1;
    phi(phi>0)=1;
    phi(phi<=0)=-1;
    T = phi>0;TT=phi<=0;phi=T-TT;
    phi = double((phi>0).*(bwdist(phi<0)-0.5)-(phi<0).*(bwdist(phi>0)-0.5));
    hold on
end
figure ; contour(phi,[0 0],'LineWidth',2); axis equal;
title('Level Set Active Contour','LineWidth',2); 

