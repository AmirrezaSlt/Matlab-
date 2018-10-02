clc
clear
close all
a=ones(30,300);
f=zeros(300,300);
for k=1:10
    d=mod(k,2);
    f(30*(k-1)+1:30*k,:)=d*a;
end
figure,imshow(f,[])
[u,v]=ginput(4);
t=pi/3;
[M,N]=size(f);
for m = 1:M
    for n = 1:N
        x=fix(10+m*cos(t)+n*sin(t)+0.002*m*n);
        y=fix(6-m*sin(t)+n*cos(t)+0.004*m*n);
        if x>0 && y>0
            Transform(x,y)=f(m,n);
        end
    end
end
[X,Y]=size(Transform);
figure,imshow(Transform,[]),title('Transformed Image')
% for x=1:X
%     for y=1:Y
%         M=[cos(Transform) sin(Transform);-sin(Transform) cos(Transform)];
%         c=[10+0.02;6+0.004];
%         p=M\([x;y]-c);
%         p1=p(1);
%         p2=p(2);
%         r=interp2(f,p1,p2,'Nearest Neighborhood');
%         gs(x,y)=r;
%     end
% end
[x,y]=ginput(4);
X=[x,y,[1;1;1;1]];
U=[u,v,[1;1;1;1]];
A=U\X;
    