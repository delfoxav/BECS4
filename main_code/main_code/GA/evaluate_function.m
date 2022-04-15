function value = evaluate_function(P, lowerLimits, higherLimits, genes, func, use_GPU, tamb)
%% Evaluation of any function result for  the Genetic algoritm 
% return the values corresponding to the individuals of the populations
% takes a set of genes in binary as input
    % P = population
    % lowerLimits = vector of the lower bound on each variable
    % higherLimits = vector of the higher bound on each variable
    % genes = vector of genes used for each variable
    % func = function to evaluate
    % use_GPU = define if the computation has to be performed using the GPU
    % tamb = ambiant temperature



    [x1, y1] = size(P);
    
    % if the GPU is used create GPU arrays, preallocation 
    if use_GPU
        H = gpuArray(zeros(1,x1));
        tmp = gpuArray(zeros(size(lowerLimits)));
        values = gpuArray(zeros(size(lowerLimits)));
    else
        H = zeros(1,x1);
        tmp = zeros(size(lowerLimits));
        values = zeros(size(lowerLimits));
    end

     % We convert the value back to decimal numbers
    for i = 1: x1
        a = 0;
        b = 1;
        for j = 1: length(genes)
            a = a + genes(j); % store the number of genes of the current chromosome in a
            tmp(j) = bin2dec(num2str(P(i,b:a))); % convert the bin set back to decimal number
            values(j) = lowerLimits(j) + tmp(j) *(higherLimits(j) - lowerLimits(j))/(2^(genes(j))-1); % scale the number in the value range
            b = a+1;
        end    
        H(1,i) = func(values, tamb);
    end
    value = H;