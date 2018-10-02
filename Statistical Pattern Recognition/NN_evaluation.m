function pe = NN_evaluation(net,x,y)
    y1 = sim(net,x); %Computation of the network outputs
    pe=sum(y.*y1<0)/length(y);
end