function NN=CreateSigmoidNN(numinput,hiddenlayer)
n=size(hiddenlayer,2);
NN{1}=rand(numinput+1,hiddenlayer(1));
for i=2:n
    NN{i}=rand(hiddenlayer(i-1)+1,hiddenlayer(i));
end
end 

