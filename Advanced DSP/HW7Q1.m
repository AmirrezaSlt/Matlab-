clc
clear
close all
Ts=1/1000;
t=0:Ts:0.3;
f1=7000/16;
f2=5000/16;
f3=1000/16;
x=cos(2*pi*f1*t)+cos(2*pi*f2*t)+cos(2*pi*f3*t);
maximum_iterations=3;
wavelet='sym2';
[C,L]=wavedec(x,1,wavelet);
coeffs=zeros(maximum_iterations+1,length(C));
coeffs(1,:)=C;
tree=zeros(maximum_iterations,2^(maximum_iterations+1));
figure,plot(C(1:length(C)/2)),title('c11')
figure,plot(C(length(C)/2+1:end)),title('c12')
for i=1:maximum_iterations 
    for j=1:2^i
        s=coeffs(i,1+length(C)*(j-1)/(2^i):length(C)*j/(2^i));
        if sum(abs(s))~=0
            tree(i,round(length(tree)*(2*j-1)/(2^(i+1))))=1;
            eo=myentropy(s);
            [cs,~]=wavedec(s,1,wavelet);
            en1=myentropy(cs(1:length(cs)/2));
            en2=myentropy(cs(length(cs)/2+1:end));
            en=en1+en2;
            if en<eo && i~=maximum_iterations
                coeffs(i+1,1+length(C)*(j-1)/(2^i):length(C)*j/(2^i))...
                    =cs(2:length(s)+1);
            elseif i~=1
                figure,plot(s),title(['c',num2str(i),num2str(j)])
            end
        end
    end
end
tree=[zeros(1,length(tree));tree];
tree(1,round(length(tree)/2))=1;
figure,imagesc(tree),title('Tree Diagram for Wavelet Packet')