function net = NN_training(x,y,k,code,iter,par_vec)
    rand('seed',0)  % Initialization of the random number% generators
    randn('seed',0) % for reproducibility of net initial
    % conditions
    % List of training methods
    methods_list = {'traingd'; 'traingdm'; 'traingda'};
    % Limits of the region where data lie
    limit = [min(x(:,1)) max(x(:,1)); min(x(:,2)) max(x(:,2))];
    % Neural network definition
    net = newff(limit,[k 1],{'tansig','tansig'},...
    methods_list{code,1});
    % Neural network initialization
    net = init(net);
    % Setting parameters
    net.trainParam.epochs = iter;
    net.trainParam.lr=par_vec(1);
    if(code == 2)
        net.trainParam.mc=par_vec(2);
    elseif(code == 3)
        net.trainParam.lr_inc = par_vec(3);
        net.trainParam.lr_dec = par_vec(4);
        net.trainParam.max_perf_inc = par_vec(5);
    end
    % Neural network training
    net = train(net,x,y);
    %NOTE: During training, the MATLAB shows a plot of the
    % MSE vs the number of iterations.
end
