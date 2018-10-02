function print(memory)
    load('Binary-interaction-parameters.mat');
    load('pure-properties of component.mat');
    fprintf('------\t-----------------\t--kelvin--\t---Mpa----\t --------\n');
    fprintf('number\tmaterial name    \tTcr-Rankin\tPcr--psi--\tVcri-ft3/lbmole\n');
    fprintf('------\t-----------------\t----------\t----------\t---------\n');
    for i=1:9
        if i==9
            fprintf('\t%d\t\t%s\t\t\t..................................\n',i,memory{i});
        else
            fprintf('\t%d\t\t%s\t\t\t%f\t%f\t%f\n',i,memory{i},pure_prop(i,1),pure_prop(i,2),pure_prop(i,3));
        end
    end
end