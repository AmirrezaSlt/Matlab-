clc
close all
%Part 1
a=data./max(abs(data));
%[t,f]=quantiz(a,-1:0.4:1,-1.2:0.4:1.2);
%sound(a,fs)
%sound(f,fs)
%for j=1:6
%    k=2.^j;
%[I,Q,D]=quantiz(a,-1:2/k:1,-1-1/k:2/k:1+1/k);
%[u1,u2]=lloyds(a,-1-1/k:2/k:1+1/k);
%[t1,t2,t3]=quantiz(a,u1,u2);
%sound(Q,fs)
%subplot(2,1,1)
%plot (k,D,'or')
%hold on
%subplot(2,1,2)
%plot(k,t3,'or')
%hold on
%end 
%[c,d]=lloyds(a,-1-1/8:2/8:1+1/8);
%[I,Q,D]=quantiz(a,c,d);
%sound(Q,fs)
%Part 2 
%m=compand(a,255,1,'mu/expander');
%[m1,m2,m3]=quantiz(a,-1:2/8:1,-1-1/8:2/8:1+1/8);
%mout=compand(a,255,1,'mu/compressor');
%sound(mout,fs)
% n=compand(a,255,1,'A/expander');
% [n1,n2,n3]=quantiz(a,-1:2/8:1,-1-1/8:2/8:1+1/8);
%  nout=compand(a,255,1,'A/compressor');
%  sound(nout,fs)
  predictor=[0,1];
 [p1,p2]=dpcmenco(a,-1-1/8:2/8:1+1/8,-1:2/8:1,predictor);
 soundrecover=dpcmdeco(p1,-1-1/8:2/8:1+1/8,predictor);
 a1=transpose(soundrecover);
 d=sum((a1-a).*(a1-a))./96375
% sound(soundrecover,fs)
[o1,o2,o3]=dpcmopt(a,1,-1-1/8:2/8:1+1/8);