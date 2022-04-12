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
        error("lowerLimits : Double expected but %s was given ",class(lowerLimits));
    end
    if ~isnumeric(higherLimits)
        error("higherLimits : Double expected but %s was given ",class(higherLimits));
    end
    if ~isnumeric(genes)
        error("genes : Double expected but %s was given ",class(genes));
    end
    if ~isa(objfunc,'function_handle')
        error("objfunc : function handle expected but %s was given " ,class(objfunc));
    end
    if ~isa(pricefunc,'function_handle')
        error("pricefunc : function handle expected but %s was given " ,class(pricefunc));
    end
    if ~isa(yieldfunc,'function_handle')
        error("yieldfunc : function handle expected but %s was given " ,class(yieldfunc));
    end
    if ~islogical(use_GPU)
        error("use_GPU : boolean expected but %s was given " ,class(use_GPU));
    end

    % Checks if each vector has the same size
    if length(lowerLimits) ~= length(higherLimits) || length(higherLimits) ...
            ~= length(genes) || length(genes) ~= length(lowerLimits)
        error("Lowerlimts (%d) , Higherlimits (%d) and genes (%d) must have the same sizes.", ...
            length(lowerLimits), length(higherLimits), length(genes));
    end
    
    % Checks if the lowerLimits is lower than the higherLimits, the type of
    % the values and if all the precisions are positives
    for i=1:length(lowerLimits)

        if lowerLimits(i) >= higherLimits(i)
            error("A lower limit (%d) is higher than a higher limit (%d). Please correct this issue", ...
                lowerLimits(i), higherLimits(i));
        end
        if genes(i) <= 0
            error("genes must be higher than 0.");
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
        tmp(1) = bin2dec(num2str(P(i,1:genes(1)))); % convert the bin set back to decimal number
        values(1) = lowerLimits(1) + tmp(1) *(higherLimits(1) - lowerLimits(1))/(2^(genes(1))-1); % scale the number in the value range
        tmp(2) = bin2dec(num2str(P(i,genes(1)+1:genes(1)+genes(2)))); % convert the bin set back to decimal number
        values(2) = lowerLimits(1) + tmp(2) *(higherLimits(2) - lowerLimits(2))/(2^(genes(2))-1); % scale the number in the value range
        tmp(3) = bin2dec(num2str(P(i,genes(1)+genes(2)+1:genes(1)+genes(2)+genes(3)))); % convert the bin set back to decimal number
        values(3) = lowerLimits(3) + tmp(3) *(higherLimits(3) - lowerLimits(3))/(2^(genes(3))-1); % scale the number in the value range
        
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