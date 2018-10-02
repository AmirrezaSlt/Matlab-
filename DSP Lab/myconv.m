function y=myconv(x,h)
if length(h)>length(x)
    z=x;
    x=h;
    h=z;
end
M=length(x);
N=length(h);
y=zeros(1,M+N-1);
x=fliplr(x);
for k=1:N+M-1
   if k<=N
       y(k)=sum(h(1:k).*x(M-k+1:M));
   elseif k<=M && k>N
       y(k)=sum(h(1:N).*x(M-k+1:M+N-k));
   else
        y(k)=sum(h(k-M+1:N).*x(1:M+N-k));
   end
end