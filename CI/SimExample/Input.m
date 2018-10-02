clc
close all
inputdelayed=[0;input(1:end-1)];
input2delayed=[0;0;input(1:end-2)];
outputdelayed=[0;output(1:end-1)];
output2delayed=[0;0;output(1:end-2)];
output3delayed=[0;0;0;output(1:end-3)];
x=[input inputdelayed input2delayed outputdelayed output2delayed output3delayed]';
t=output';
nftool
