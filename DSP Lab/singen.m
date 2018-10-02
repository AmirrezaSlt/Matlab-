function x = singen(w0,y)
num = [0 sin(w0)];
den = [1 -2*cos(w0) 1];
x=filter(num,den,y);
end 