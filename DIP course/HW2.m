%% Part 1 
clc
clear
close all
f0=1/50;
b=4/25000;
f=zeros(1000,1000);
for x=1:1000
    for y=1:1000
        r=sqrt((x-500)^2+(y-500)^2); % Circle Equation
        f(x,y)=cos(2*pi*(f0*r+0.5*b*r^2));
    end
end
xscale=0.4;
yscale=0.4;
dx=1/xscale;
dy=1/yscale;
% Nearest Neighborhood 
mc=0;
for m=1:dx:1000
    mc=mc+1;
    nc=0;
    for n=1:dy:1000
        nc=nc+1;
        m1=round(m);
        n1=round(n);
        gnn(mc,nc)=f(m1,n1);
    end
end
% Linear 
K=[1 -1 -1 1;0 1 0 -1;0 0 1 -1;0 0 0 1]; % Matrix initialization
mc=0;
for m=1:dx:999
    mc=mc+1;
    nc=0;
    for n=1:dy:999
        nc=nc+1;
        m1=fix(m);
        n1=fix(n);
        delx=m-m1;
        dely=n-n1;
       gl(mc,nc)=[f(m1,n1) f(m1+1,n1) f(m1,n1+1) f(m1+1,n1+1)]*K*[1;delx;dely;delx*dely];
    end
end
% Spline
C=[-0.5 1.5 -1.5 0.5;1 -2.5 2 -0.5;-0.5 0 0.5 0;0 1 0 0]; % Matrix Initialization
mc=0;
for m=2:dx:998
    mc=mc+1;
    nc=0;
    for n=2:dx:998
        nc=nc+1;
        m1=fix(m);
        n1=fix(n);
        delx=m-m1;
        dely=n-n1;
        coeffs=C*[f(m1-1,n1-1) f(m1-1,n1) f(m1-1,n1+1) f(m1-1,n1+2);...
        f(m1,n1-1) f(m1,n1) f(m1,n1+1) f(m1,n1+2);f(m1+1,n1-1) f(m1+1,n1)...
        f(m1+1,n1+1) f(m1+1,n1+2);f(m1+2,n1-1) f(m1+2,n1) f(m1+2,n1+1)... 
        f(m1+2,n1+2)];
        points=[delx^3 delx^2 delx 1]*coeffs;
        coeffs2=C*points';
        point=[dely^3 dely^2 dely 1]*coeffs2;
        gspl(mc,nc)=point;
    end
end
figure,imshow(f,[]),title('Original Image')
figure,imshow(gnn,[]),title('Nearest Neighbor Interpolation')
figure,imshow(gl,[]),title('Linear Interpolation')
figure,imshow(gspl,[]),title('Spline Interpolation')
%Image Reconstruction
% Nearest Neighborhood 
mc=0;
for m=1:1/dx:1000/dx
    mc=mc+1;
    nc=0;
    for n=1:1/dy:1000/dy
        nc=nc+1;
        m1=round(m);
        n1=round(n);
        gnnr(mc,nc)=gnn(m1,n1);
    end
end
figure,imshow(gnnr,[]),title('Nearest Neighborhood Reconstructed')
% Linear
mc=0;
for m=1:1/dx:(1000-dx)/dx
    mc=mc+1;
    nc=0;
    for n=1:1/dy:(1000-dx)/dx
        nc=nc+1;
        m1=fix(m);
        n1=fix(n);
        delx=m-m1;
        dely=n-n1;
       glr(mc,nc)=[gl(m1,n1) gl(m1+1,n1) gl(m1,n1+1) gl(m1+1,n1+1)]*K*[1;delx;dely;delx*dely];
    end
end
figure,imshow(glr,[]),title('Linear Reconstructed')
% Spline
mc=0;
for m=1+dx:1/dx:(1000-2*dx)/dx
    mc=mc+1;
    nc=0;
    for n=1+dx:1/dx:(1000-2*dx)/dx
        nc=nc+1;
        m1=fix(m);
        n1=fix(n);
        delx=m-m1;
        dely=n-n1;
        coeffs=C*[gspl(m1-1,n1-1) gspl(m1-1,n1) gspl(m1-1,n1+1) gspl(m1-1,n1+2);...
        gspl(m1,n1-1) gspl(m1,n1) gspl(m1,n1+1) gspl(m1,n1+2);gspl(m1+1,n1-1) gspl(m1+1,n1)...
        gspl(m1+1,n1+1) gspl(m1+1,n1+2);gspl(m1+2,n1-1) gspl(m1+2,n1) gspl(m1+2,n1+1)... 
        gspl(m1+2,n1+2)];
        points=[delx^3 delx^2 delx 1]*coeffs;  % 16 points reduced to 4 points
        coeffs2=C*points';
        point=[dely^3 dely^2 dely 1]*coeffs2;  % 4 points reduced to 1 point
        gsplr(mc,nc)=point;
    end
end
figure,imshow(gsplr,[]),title('Spline Reconstructed')
fnnr=imresize(f,xscale,'nearest');
flr=imresize(f,xscale,'bilinear');
fsplr=imresize(f,xscale,'bicubic');
figure,imshow(fnnr,[]),title('Imresize Nearest Neighborhood')
figure,imshow(flr,[]),title('Imresize Linear')
figure,imshow(fsplr,[]),title('Imresize Spline')
%% Part 2 
clc
clear
close all
f=zeros(300,300);
% Creating the Image
for m=1:300
    for n=1:300
        f(m,n)=cos(2*pi*50/300*m+2*pi*55/300*n)+cos(2*pi*55/300*m+2*pi*50/300*n);
    end
end
F=fft2(f);
figure,mesh(abs(F))
M=100;
g=f(1:M,1:M); % Cropping to the first M points of the image
G=fft2(g,300,300);
figure,mesh(abs(G))
figure,imshow(f,[])
figure,imshow(g,[])
%% Part 3 
clc
clear
close all
g=zeros(200,200);
%Creating the fft shifted version (the circle)
for m=1:200
    for n=1:200
        if (m-100)^2+(n-100)^2==50^2
            g(m,n)=1;
        end
    end
end
figure,mesh(abs(g))
f=(ifft2(g)); % Time-domain equivalent of the fftshifted image
% converting to time-domain equivalent of the original (unshifted) image
for m=1:200
   for n=1:200
       f2(m,n)=((-1)^(m+n))*f(m,n);
   end
end
figure,imshow(f2,[])
F=fft2(f2);
figure,mesh(abs(F))
% Testing aliasing limit
fl=imresize(f2,0.5);
figure,imshow(fl,[])
FL=fft2(fl);
figure,mesh(abs(fft2(fl)))