function value = evaluation(P, lowerLimits, higherLimits, genes, objfunc, pricefunc, yieldfunc, use_GPU)
%% Evaluation of the Genetic algoritm results
% return the values corresponding to the individuals of the populations
    % P = population
    % lowerLimits = vector of the lower bound on each variable
    % higherLimits = vector of the higher bound on each variable
    % genes = vector of genes used for each variable
    % objfunc = function to optimize
    % pricefunc = function showing the price of the reaction
    % yieldfunc = function showing the yield of the reaction
    % use_GPU = define if the computation has to be performed using the GPU
    
    % Checks the type of the inputs
    if ~isnumeric(P)
        error("P : Double expected but %s was given ",class(P))
    end
    if ~isnumeric(lowerLimits)
        error("lowerLimits : Double expected but %s was given ",class(lowerLimits))
    end
    if ~isnumeric(higherLimits)
        error("higherLimits : Double expected but %s was given ",class(higherLimits))
    end
    if ~isnumeric(genes)
        error("genes : Double expected but %s was given ",class(genes))
    end
    if ~isa(objfunc,'function_handle')
        error("objfunc : function handle expected but %s was given " ,class(objfunc))
    end

    % Checks if each vector has the same size
    if length(lowerLimits) ~= length(higherLimits) || length(higherLimits) ...
            ~= length(precisions) || length(precisions) ~= length(lowerLimits)
        error("Lowerlimts (%d) , Higherlimits (%d) and precisions (%d) must have the same sizes.", ...
            length(lowerLimits), length(higherLimits), length(precisions))
    end
    
    % Checks if the lowerLimits is lower than the higherLimits, the type of
    % the values and if all the precisions are positives
    for i=1:length(lowerLimits)

        if lowerLimits(i) >= higherLimits(i)
            error("A lower limit (%d) is higher than a higher limit (%d). Please correct this issue", ...
                lowerLimits(i), higherLimits(i))
        end
        if precisions(i) <= 0
            error("Precisions must be higher than 0.")
        end
    end
        




    [x1, y1] = size(P);
    if use_GPU
        H = gpuArray(zeros(1,x1));
        tmp = gpuArray(zeros(size(lowerLimits)));
        values = gpuArray(zeros(size(lowerLimits)));
    else
        H = zeros(1,x1);
        tmp = zeros(size(lowerLimits));
        values = zeros(size(lowerLimits));
    end
   
    for i = 1: x1
        for j = 1: length(genes)
            tmp(j) = bin2dec(num2str(P(i,1:genes(j)))); % convert the bin set back to decimal number
            values(j) = lowerLimits(j) + tmp(j) *(higherLimits(j) - lowerLimits(j))/(2^(genes(j))-1); % scale the number in the value range
        end
        %Having a yield higher than 60% is mandatory, if the yield is
        %lower, the fitness is set to 0. We also want to spend less than 1
        %CHF per % of yield
        if yieldfunc(values) >= 60 && pricefunc(values) <= yieldfunc(values) 
            H(1,i) = objfunc(values);
        else
            H(1,i) = 0;
        end
    end
    value = H;