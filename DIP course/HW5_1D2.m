g=imread('WineGlass.jpg');
g=rgb2gray(g);
g=im2double(g);
g=imresize(g,0.6);
[M N]=size(g);
figure(1),imshow(g,[]),title('Original Image');

f=g+0.4*rand(M,N);
figure(2),imshow(f,[]),title('Random NOised Image');
F=abs(fftshift(fft2(f)));
figure(3),mesh(F),title('Frequency Domain of Noised Image');
%% Gaussian Window Filter
sig=0.8;
L=ceil(3*sig);
w=2*L+1;
k=1/(2*pi*sig^2);
h1=zeros(w);
for x=1:w
    for y=1:w
        h1(x,y)=k*exp(-( (x-L)^2+(y-L)^2 )/(2*sig^2));
    end
end

figure(4),mesh(h1),title('Goasian Window in Spacial Domain');
H1=abs(fftshift(fft2(h1)));
figure(5),mesh(H1),title('Goasian Window in Frequency Domain');
%%%using fspecial funcion
h2=fspecial('gaussian',2*L+1,sig);
h=h1;
%% Filtering
J=imfilter(f,h);
figure(6),imshow(J,[]),title(strcat('Filtered Image, sig=',num2str(sig),', W=',num2str(w)));
JJ=abs(fftshift(fft2(J)));
figure(7),mesh(JJ),title('Filtered Image in Freq. Domain');
% s=strcat('Filtered_',num2str(sig),'_',num2str(w),'.jpg');
% mx=max(max(J));
% J=J/mx;
% cmap=colormap('gray');
% imwrite(J,cmap,s,'jpeg');