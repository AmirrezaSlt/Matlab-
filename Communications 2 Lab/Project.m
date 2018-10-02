clear all;
 close all;
 clc;

sr=256000.0;           
nd =10^5; 
Fd = 1;                
    
Fs = 8;                
     
tone=10;
M=2;
ml=log(M)/log(2); 
 br=sr.*ml;          
 

j=1;
for ebn0=0:12
noe = 0;    
nod = 0;    

	seridata=randi(1,nd,M);   

    modsignal = fskmod(seridata,M,Fd,tone,Fs); 
    ich1=real(modsignal);
    qch1=imag(modsignal);

    spow=sum(ich1.^2+qch1.^2)/nd;  
    attn=0.5*spow*sr/br*10.^(-ebn0/10);
    attn=sqrt(attn);

    ich2=ich1+randn(1,length(ich1)).*attn;
    qch2=qch1+randn(1,length(qch1))*attn;
    
    ynoisy=ich2+1i*qch2; 
 
    [demodata] = fskdemod(ynoisy,M,Fd,tone,Fs);    
        
    [noe2,rate(j)] = symerr(demodata,seridata);  
    nod2=length(seridata); 

    noe=noe+noe2;
    nod=nod+nod2;
     

ber(j)=noe/(nod*ml);
% fprintf('Eb/No=%f\tBit error rate=%e\n',ebn0,ber(j));
% pause(.1);
j=j+1;
end
ebn=[0:12];
theoryBer = 0.5*exp(-(10.^(ebn/10))/2);

figure(1)
semilogy([0:12],ber),...
          xlabel(' Eb/No (dB)'),ylabel('BER'),...
         title('performance of  noncoherent BFSK under AWGN channel');
hold on     
semilogy([0:12],theoryBer,'r-');
grid on 
 
legend('simulation of noncoh 2-FSK ','Theory of noncoh 2-FSK ');