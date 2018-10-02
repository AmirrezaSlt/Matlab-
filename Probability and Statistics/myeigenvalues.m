function L=myeigenvalues(A)
[M,~]=size(A);
I=eye(M);
% c=0;
% step=0.001;
% x=-2:step:2;
% for i=-2:step:2
%     c=c+1;
%     f(c)=det(A-i.*I);
% end
% a=polyfit(x,f,50);
% sol=roots(a);
g=charpoly(A);
L=roots(g);
% L=fzero(f,0);
% i=0;
% r=[];
% if det(A)==0
%     r=[0];
% end
% j=1;
% while length(r)<M
%    i=i+0.01;
%    if abs(det(A-i.*I))<0.08
%        r=[r;i];
%        j=j+1;
%    end
%    if abs(det(A+i.*I))<0.08
%        r=[r;-i];
%        j=j+1;
%    end
% end
end