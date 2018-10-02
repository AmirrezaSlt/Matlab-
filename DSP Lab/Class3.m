clc
clear
close all
%% Part 3
[x,fs]=audioread('Audio01.wav');
h=matfile('filter2.mat');
y0=filter(h.Num,1,x);
freqz(y0)
title('Prefiltered signal')
f0=12000;
Ts=1/fs;
t=0:Ts:(length(x)-1)*Ts;
c=cos(2*pi*f0*t');
y1=y0.*c;
figure
freqz(y1)
title('signal sent with carrier')
% sound(y1,fs)
y2=filter(h.Num,1,y1);
figure
freqz(y2)
title('message signal filtered again')
% sound(y2,fs)
y3=y2.*c;
figure
freqz(y3)
title('shifting back signal frequency')
y4=filter(h.Num,1,y3);
figure
freqz(y4)
title('final message filtered')
sound(y4,fs)
% The signal has changed very little because the filter used is not
% ideal(but close),also because of the two times using carriers the signal
% power was effectively halved.
%% Part 4
clc
clear
close all
[x,fs]=audioread('Audio02.wav');
x=x(:);
figure 
freqz(x)
title('x')
[ca,cb]=dwt(x,'db1');
figure
freqz(ca)
title('ca')
figure
freqz(cb)
title('cb')
cna=awgn(ca,50);
cnb=awgn(cb,50);
figure
freqz(cna)
title('ca noisy')
figure
freqz(cnb)
title('cb noisy')
x_noisy=idwt(cna,cnb,'db1');
figure 
freqz(x_noisy)
title('x noisy')
[caa,cbb]=dwt(ca,'db1');

