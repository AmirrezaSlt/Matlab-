clc
clear      
close all
load('data.mat')
input=zeros(400,10); 
n=150; % The number of pixels we reverse
disp('Please enter any key to continue unscrambling the image')
for i=1:10
%     figure;
%     h=imagesc(numbers{i});
    temp=numbers{i};
    input(:,i)=temp(:);
end
T=double(input);
net=newhop(T);  

% b=zeros(n,10);
% for j=1:10
%     a=sort(randperm(400,n));
%     for k=1:n
%         b(k,j)=input(a(k),j);
%     end
% end
% s_i=input;
% for j=1:10
%     a=sort(randperm(400,n));
%     for k=1:n
%         s_i(a(k),j)=input(a(k),j).*(-1);
%     end
% end
% s=cell(numbers);
% for i=1:10
%     figure;
%     imagesc(reshape(s_i(:,i),20,20));
%     s{i}=reshape(s_i(:,i),20,20);
%     pause
% end
for i=1:10
    a=randperm(400,n);
    T(a,i)=T(a,i)*-1;
%     figure
%     h=imagesc(reshape(T(:,i),20,20));
end
y = sim(net,{10,25},{},{T});
for i=1:10
    for j=1:25
    temp=y{j}(:,i);
    imagesc(reshape(temp,20,20));
    pause;
    end
end


