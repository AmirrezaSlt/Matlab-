o=output-100000;
[val,ind]=max(o,[],1);
o_onehot=zeros(size(output));
for i=1:size(o,2)
    o_onehot(ind(i),i)=1;
end

