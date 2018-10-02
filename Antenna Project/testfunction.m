function f=testfunction(D,lambda)
phase=linspace(-pi, pi, 1000);
for i=1:size(D,1)
    for k=1:length(phase)
        dd=D(i,1);
        g=0;
        for p=1:size(D,2)
            g=g+exp((j*2*pi/lambda)*dd*cos(phase(k)));
            dd=dd+D(i,p);
        end
        o(i,k)=abs(g)/size(D,2);
    end
end
for i=1:size(D, 1) 
    p=findpeaks(o(i,:));
    p=sort(p);
    f(i)=-20*log10(p(end)/p(end-3));
end