clc;
clear;

x = (0:0.1:10)';
y = sin(2*x)./exp(x/-3);
trnData = [x y];
numMFs = 15;
mfType = 'gbellmf';
epoch_n = 30;
in_fis = genfis1(trnData,numMFs,mfType,'constant');

[x1,mf] = plotmf(in_fis,'input',1);
subplot(2,1,1), plot(x1,mf);
xlabel('Before Train');

out_fis = anfis(trnData,in_fis,20);

[x1,mf] = plotmf(out_fis,'input',1);
subplot(2,1,2), plot(x1,mf);
xlabel('After Train');

figure
x = (0:0.05:10)';
y = sin(2*x)./exp(x/-3);
plot(x,y,x,evalfis(x,out_fis));
legend('Training Data','ANFIS Output');
