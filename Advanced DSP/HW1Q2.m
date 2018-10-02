clc
clear
close all
rate=1/200;
b=0.5;
t=-b:rate:b;
f=200*sinc(2*pi*100*t);
F=fft(f);
L=length(F);
w=0:2*pi/L:2*pi-2*pi/L;
subplot(3,2,1)
plot(t,f)
title({['Signal in Time Domain from ',num2str(-b),' to ',num2str(b)];...
[' with Sampling Rate ',num2str(rate)]});
subplot(3,2,2)
plot(w,abs(F))
title({['Signal in Frequency Domain from ',num2str(-b),' to ',num2str(b)];...
[' with Sampling Rate ', num2str(rate)]});
rate=1/400;
b=0.5;
t=-b:rate:b;
f=200*sinc(2*pi*100*t);
F=fft(f);
L=length(F);
w=0:2*pi/L:2*pi-2*pi/L;
subplot(3,2,3)
plot(t,f)
title({['Signal in Time Domain from ',num2str(-b),' to ',num2str(b)];...
[' with Sampling Rate ',num2str(rate)]});
subplot(3,2,4)
plot(w,abs(F))
title({['Signal in Frequency Domain from ',num2str(-b),' to ',num2str(b)];...
[' with Sampling Rate ', num2str(rate)]});
rate=1/400;
b=0.2;
t=-b:rate:b;
f=200*sinc(2*pi*100*t);
F=fft(f);
L=length(F);
w=0:2*pi/L:2*pi-2*pi/L;
subplot(3,2,5)
plot(t,f)
title({['Signal in Time Domain from ',num2str(-b),' to ',num2str(b)];...
[' with Sampling Rate ',num2str(rate)]});
subplot(3,2,6)
plot(w,abs(F))
title({['Signal in Frequency Domain from ',num2str(-b),' to ',num2str(b)];...
[' with Sampling Rate ', num2str(rate)]});