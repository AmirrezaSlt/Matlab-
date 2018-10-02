clc
clear
close all
% f=zeros(30);
global tag
tag=1;
% for m=1:30
%     for n=1:30
%         r=sqrt((m-10)^2+(n-10)^2);
%         if r<7 f(m,n)=1;end
%         r=sqrt((m-18)^2+(n-18)^2);
%         if r<5 f(m,n)=0;end
%         r=sqrt((m-25)^2+(n-25)^2);
%         if r<3 f(m,n)=1;end
%     end
% end
% f(24:28,5:6)=1;
% f(27:28,5:11)=1;
% f(10:28,9:11)=1;
% f(10:16,11:15)=1;
% f(15:24,14:15)=1;
% f(5:15,20:28)=1;
% f(8:25,9:13)=0;
% f(22:27,10:11)=1;
% f(7:10,23:25)=0;
% ff=imrotate(f,90);
% f=[ff,f;f,ff];
% figure,imshow(f,[])
% g=[f f f;f f f;f f f];
% figure,imshow(g,[])
% label=zeros(size(g));
% for m=1:size(g,2)
%     for n=1:size(g,1)
%         [k,label]=spread(g,label,m,n,1);
%     end
% end
% ln=5;
% % Uncomment the following line to change the default label number
% %ln=input('Enter an integer from 1 to 145 ');
% s=zeros(size(label));
% xmin=180;
% ymin=180;
% xmax=0;
% ymax=0;
% for m=1:180
%     for n=1:180
%         if label(m,n)==ln
%             s(m,n)=1;
%             if m>xmax;xmax=m;end
%             if n>ymax;ymax=n;end
%             if m<xmin;xmin=m;end
%             if n<ymin;ymin=n;end
%         end
%     end
% end
% figure,imshow(s,[])
% sc=s(xmin-1:xmax+1,ymin-1:ymax+1);
% scc=imresize(sc,[180,180]);
% figure,imshow(scc,[])
% gs=conv2(g,sc,'same');
% gm=max(max(gs));
% gs2=zeros(size(gs));
% for m=1:180
%     for n=1:180
%         if gs(m,n)==gm;gs2(m,n)=1;end
%     end
% end
% figure,imshow(gs2,[])
f=imread('bloodcells1.jpg');
f=rgb2gray(f);
[M,N]=size(f);
h=imhist(f);   
p=h/(M*N); 
w=51;
k=0.1;
fp=padarray(f,[(w-1)/2 (w-1)/2],'symmetric','both');
fstd=128;
for m=(1+(w-1)/2):M+2
    for n=(1+(w-1)/2):N+2
        fw=fp(m-(w-1)/2:m+(w-1)/2,n-(w-1)/2:n+(w-1)/2);
        wstd=std2(fw);
        wm=mean2(fw);
        T(m-(w-1)/2,n-(w-1)/2)=wm*(1-k*(1-(wstd/fstd)));
        g4(m-(w-1)/2,n-(w-1)/2)=fp(m,n) >= T(m-(w-1)/2,n-(w-1)/2);
    end 
end
label2=zeros(size(g4));
[M2,N2]=size(g4);
for m=1:M2
    for n=1:N2
        g4(m,n)=1-g4(m,n);
    end
end
for m=1:M2
    for n=1:N2
        [k2,label2]=spread(f,label2,m,n,1);
    end
end
function [list,label]=spread(f,label,x,y,t)
global tag
    if f(x,y)==1 && label(x,y)==0
        label(x,y)=tag;
        list=[x-1 y+1 x y+1 x+1 y+1 x-1 y x y x+1 y x-1 y-1 x y-1 x+1 y-1];
        while isempty(list)==0
           [n1,label]=spread(f,label,list(1),list(2),0);
           list(2)=[];
           list(1)=[];
           if n1~=0 
               list=[list,n1] ; 
           end
        end 
         if t==1
           tag=tag+1;
         end
    end
    list=0;
end