function y=feedforward(x,w,v)
[r,c]=size(x);
a1=[x;-ones(1,c)];
o1=sigmoid(w*a1);
[r1,c1]=size(o1);
a2=[o1;-ones(1,c1)];
y=sigmoid(v*a2);


