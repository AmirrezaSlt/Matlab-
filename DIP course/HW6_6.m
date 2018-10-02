%% Loading Data
clc
clear
close all
ftemp=zeros(2,2,3);
f=zeros(8,2,2,3);
for i=1:8
    fstr=strcat('Zebra',num2str(i),'.jpg');
    ftemp=imread(fstr);
    if size(ftemp,1)>size(f,2)
        f=padarray(f,[0,1,0,0]*(size(ftemp,1)-size(f,2)),'post');
    end
    if size(ftemp,2)>size(f,3)
        f=padarray(f,[0,0,1,0]*(size(ftemp,2)-size(f,3)),'post');
    end
    f(i,1:size(ftemp,1),1:size(ftemp,2),1:size(ftemp,3))=ftemp;
end
g=imread('Zebra2.jpg');
[M,N,~]=size(g);
figure,imshow(g,[]),title('Original Image')
%% Extracting RGB Values for White and Black
% Select one of the options:1)Manual Extraction 2)preprocessed data
% white=impixel(g);white=double(mean(white));
% black=impixel(g);black=double(mean(black));
white=[119.5714 122.7143 128.8571];
black=[21.667 17.5238 18.5238];
%% Absolute Distance
g1=double(g);
w=140;
B1=zeros(M,N);
for m=1:M
    for n=1:N
        r=g1(m,n,1);
        g=g1(m,n,2);
        b=g1(m,n,3);
        if abs(r-white(1))<=w/2 && abs(g-white(2))<=w/2 && abs(b-white(3))<=w/2
            B1(m,n)=1;
        elseif abs(r-black(1))<=w/2 && abs(g-black(2))<=w/2 && abs(b-black(3))<=w/2
            B1(m,n)=1;
        end
    end
end
figure,imshow(B1,[]),title(['Absolute Distance with W = ' num2str(w) ]);
%% Euclidean Distance
B2=zeros(M,N);
for m=1:M
    for n=1:N
        r=g1(m,n,1);
        g=g1(m,n,2);
        b=g1(m,n,3);
        D1=sqrt((r-white(1))^2+(g-white(2))^2+(b-white(3))^2);
        D2=sqrt((r-black(1))^2+(g-black(2))^2+(b-black(3))^2);
        if D1<=w/2
            B2(m,n)=1;
        elseif D2<=w/2
            B2(m,n)=1;
        end
    end
end
figure,imshow(B2,[]),title(['Spherical Method with W = ' num2str(w) ]);
%% Mahalanobis Distance
% for i=1:8
%     ftemp=squeeze(f(i,:,:,:));
%     L=impixel(ftemp);
%     white=[white;L];
% end
% for i=1:8
%     ftemp=squeeze(f(i,:,:,:));
%     L=impixel(ftemp);
%     black=[black;L];
% end
E_white=mean(white,1);
E_black=mean(black,1);
A=padarray(E_white,[size(white,1)-1 0],'replicate','post');
B=padarray(E_black,[size(black,1)-1 0],'replicate','post');
sigma_white=((white-A)'*(white-A))/size(white,1)-1;
sigma_black=((black-B)'*(black-B))/size(black,1)-1;
g1=double(g);
w=120;
B3=zeros(M,N);
parfor m=1:M
    for n=1:N
        r=g1(m,n,1);
        g=g1(m,n,2);
        b=g1(m,n,3);
        D1=[r-E_white(1) g-E_white(2) b-E_white(3)]*inv(sigma_white)*[r-E_white(1) g-E_white(2) b-E_white(3)]';
        D2=[r-E_black(1) g-E_black(2) b-E_black(3)]*inv(sigma_black)*[r-E_black(1) g-E_black(2) b-E_black(3)]';
        if D1<=w/2
            B3(m,n)=1;
        elseif D2<=w/2
            B3(m,n)=1;
        end
    end
end
figure,imshow(B3,[]),title(['Mahalanobis Distance with W = [' num2str(w) ']']);