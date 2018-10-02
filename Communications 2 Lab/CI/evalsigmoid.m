function output=evalSigmoidNN(net,input)
[~,size_input]=length(input);
augmented_input=[input,1*ones(1,size_input)];
size_NN=length(NN);
for i=1:size_NN
    augmented_input=sigmoid(transpose(NN(i)*agumented_input);
   augmented_input=[output,ones(1,length(output))];
end

