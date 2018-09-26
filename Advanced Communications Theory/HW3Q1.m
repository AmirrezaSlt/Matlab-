clc
clear
close all
Tb=1;
Ts=2*Tb;
fc=2/Tb;
input_data=[0 0 1 0 0 0 1 1 1 0 0 0 1 1 1 1];
modulate_data=2*((input_data)-0.5);
n=0:0.005:Ts;
g1=ones(1,length(n));
% Part 1 
S_a=[];
si_a=[];
sq_a=[];
for j=1:2:length(modulate_data)
    si1=modulate_data(j)*g1;
    si2=cos(2*pi*fc*n).*si1;
    sq1=modulate_data(j+1)*g1;
    sq2=sin(2*pi*fc*n).*sq1;
    S_a=[S_a si2-sq2];
    si_a=[si_a si2];
    sq_a=[sq_a sq2];
end
 c=((length(modulate_data)/2)*Ts)/length(S_a);
 N=0:c:((length(modulate_data)/2)*Ts)-c;
plot(N,S_a)
title('Q1 Part 2 ')
xlabel('Time Domain')
ylabel('S(t)')
figure
plot(N,si_a)
title('Q1 Part 1  Si(t)cos(2pi*fc*t)')
xlabel('Time')
ylabel('Si(t)cos(2pi*fc*t)')
figure
plot(N,sq_a)
title('Part 1 of Q1  Si(t)sin(2pi*fc*t)')
xlabel('Time')
ylabel('Sq(t)sin(2pi*fc*t)')
% Part 2 
si_b=[];
sq_b=[];
for j=1:2:length(modulate_data)
    si12=modulate_data(j)*g1;
    si22=cos(2*pi*fc*n).*si12;
    sq12=modulate_data(j+1)*g1;
    sq22=sin(2*pi*fc*n).*sq12;
    si_b=[si_b si22];
    sq_b=[sq_b sq22];
end
si_b=[si_b zeros(1,(length(n)-1)/2)];
sq_b=[zeros(1,(length(n)-1)/2) sq_b];
S_b=si_b-sq_b;
b=(((length(modulate_data)/2)*Ts)+Tb)/length(S_b);
M=0:b:((length(modulate_data)/2)*Ts)+Tb-b;
figure;
plot(M,S_b)
title('Q1 Part 2')
xlabel('Time')
ylabel('S(t)')
figure;
plot(M,si_b)
title('Q1 Part 2  Si(t)cos(2pi*fc*t)')
xlabel('Time')
ylabel('Si(t)cos(2pi*fc*t)')
figure,plot(M,sq_b)
title('Q1 part 2  Si(t)sin(2pi*fc*t)')
xlabel('Time')
ylabel('Sq(t)sin(2pi*fc*t)')
% Part 3 
g2=sin((pi*n)/(2*Tb));
si_c=[];
sq_c=[];
for j=1:2:length(modulate_data)
    si13=modulate_data(j)*g2;
    si23=cos(2*pi*fc*n).*si13;
    sq13=modulate_data(j+1)*g2;
    sq23=sin(2*pi*fc*n).*sq13;
    si_c=[si_c si23];
    sq_c=[sq_c sq23];
end
si_c=[si_c zeros(1,(length(n)-1)/2)];
sq_c=[zeros(1,(length(n)-1)/2) sq_c];
S_c=si_c-sq_c;
figure
plot(M,S_c)
title('Q1 Part 3')
xlabel('Time')
ylabel('S(t)')
figure
plot(M,si_c)
title('Q1 part 3  Si(t)cos(2pi*fc*t)')
xlabel('Time')
ylabel('Si(t)cos(2pi*fc*t)')
figure
plot(M,sq_c)
title('Q1 part 3  Sq(t)sin(2pi*fc*t)')
xlabel('Time')
ylabel('Sq(t)sin(2pi*fc*t)')