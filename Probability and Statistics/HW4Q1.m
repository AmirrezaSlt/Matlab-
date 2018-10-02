clc
clear 
close all
A=randn(50);
f=myeigenvalues(A);
% f=real(f);
f=sort(f);
ft=@() myeigenvalues(A);
tf=timeit(ft);
g=eig(A);
% g=real(g);
g=sort(g);
gt=@() eig(A);
tg=timeit(gt);
for i=1:length(f)
    e(i)=abs((g(i)-f(i)))/abs(g(i));
end
error=100*mean(e);
te=tf-tg;
disp(['Our error is: ',num2str(error),' and our time difference is: ',num2str(te)])