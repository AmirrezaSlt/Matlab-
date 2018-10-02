clc
clear
close all
t=-.5:.05:.5;
w1=ones(length(t),1)';
g=.54+.46*cos(2*pi.*t);
g1=exp(-18.*(t.^2));
g2=cos(1*pi.*t).^2;
g3=.42+.5*cos(2*pi.*t)+.08*cos(4*pi.*t);
l=length(g);
  figure
   plot(t,g,'r','LineWidth',2)
   title('hamming window')
  figure
  stem(g)
 
 figure
  plot(-.5:1/l:.5-1/l,g1,'r','LineWidth',2)
  title('Gaussian window')
  figure
  plot(-.5:1/l:.5-1/l,g2,'r','LineWidth',2)
  title('hanning window')
  figure
  plot(-.5:1/l:.5-1/l,g3,'r','LineWidth',2)
 title('Blackman window')
% 

%a=sinc(t);
a=.54*sinc(t)+.23*(sinc(t-1)+sinc(t+1));
a=.42*sinc(t)+.25*(sinc(t-1)+sinc(t+1))+.04*(sinc(t-2)+sinc(t+2));
plot(t,abs(a)/max(a))


 k=0;
      for omega=-1*pi:.01:1*pi
      k=k+1;
      k1=0;
      for n=1:length(g)
            k1=k1+1;
            w(k1)=(w1(n)*exp(-i*omega*n));
            w2(k1)=(g(n)*exp(-i*omega*n));
            w3(k1)=(g1(n)*exp(-i*omega*n));
            w4(k1)=(g2(n)*exp(-i*omega*n));
            w5(k1)=(g3(n)*exp(-i*omega*n));
      
      end
           f(k)=abs((sum(w)));
           f1(k)=abs((sum(w2)));
           f2(k)=abs((sum(w3)));
           f3(k)=abs((sum(w4)));
           f4(k)=abs((sum(w5)));
      
      end
 %f1=abs(fft(g));
 l=length(f);
 a1=-pi:2*pi/l:1*pi-(2*pi/l);
 figure
 plot(((a1)),((f)/max(abs(f))),'b','LineWidth',2)
 title('fourier transform rect')
 grid on
 figure
 plot(((a1)),((f1)/max(abs(f1))),'c','LineWidth',2)
 title('fourier transform  hamming')
 grid on
 figure
 plot(((a1)),((f2)/max(abs(f2))),'r','LineWidth',2)
  title('fourier transform Gaussian')
 grid on
 figure
 plot(((a1)),((f3)/max(abs(f3))),'y','LineWidth',2)
 title('fourier transform Hanning')
 grid on
 figure
 plot(((a1)),((f4)/max(abs(f4))),'k','LineWidth',2)
  title('fourier transform Blackman')
 grid on
 
 

 
