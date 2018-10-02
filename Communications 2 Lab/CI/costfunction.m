    function cost=costfunction(x,w,v,desired)
y=feedforward(x,w,v);
[r,n]=size(input);
error=desired-y;
cost=sqrt(sum(sum(error.^2)/2))/n;