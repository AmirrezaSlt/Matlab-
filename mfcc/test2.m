clc
clear
close all
ml=2000;
input=[];
t=[];
for i=1:10
    s1=strcat('M1',num2str(i),'.mfcc');
    s2=strcat('M2',num2str(i),'.mfcc');
    a1=readhtk(s1);
    a2=readhtk(s2);
    a1=a1(:);
    a2=a2(:);
    a=[a1;a2];
    while mod(length(a),ml)~=0
        a=[a;0];
    end
    a=reshape(a,ml,[]);
    input=[input a];
    ta=zeros(10,size(a,2));
    ta(i,:)=1;
    t=[t ta];
end

% o=abs(output);
% om=max(o,[],1);
% o_onehot=zeros(size(o));
% for i=1:size(o,1)
%     for j=1:size(o,2)
%         if output(i,j)==om(j)
%             o_onehot(i,j)=1;
%         end
%     end
% end
