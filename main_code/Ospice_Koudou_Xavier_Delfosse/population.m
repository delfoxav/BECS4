% Lecture: BECS4: Optimisation Methods
% work: Optimization of a chemical reaction on a catalytic bed
% date: 25.04.2022
% authors: Ospice Koudou % Xavier Delfosse

function [value,N_genes] = population(n, lowerLimits, higherLimits, precisions,use_GPU)
%% Function to compute the initial population for the genetic algoritm
% return a Matrix of size n*m where m is the number of genes of each
% individual of the population of size n

    % n = population size
    % lowerLimits = vector of lower bounds on the differents variables
    % higherLimits = vector of higher bounds on the different variables
    % precisions = vector of desired precisons for the different variables
    % use_GPU = define if the computation has to be performed using the GPU
    

    % Checks the type of the inputs
    if ~isnumeric(n)
        error("n : Double expect but %s was given ",class(n))
    end
    if ~isnumeric(lowerLimits)
        error("lowerLimits : Double expect but %s was given ",class(lowerLimits))
    end
    if ~isnumeric(higherLimits)
        error("higherLimits : Double expect but %s was given ",class(higherLimits))
    end
    if ~isnumeric(precisions)
        error("precisions : Double expect but %s was given ",class(precisions))
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
        
    
    % In order to determine how many genes we need, we have to use the desired
    % range and precision of each variable.
    
    
    % We can then use the formula: 2^(m-1) < (upper limit - lower limit)*10^p <
    % 2^m-1 where m is the number of genes and p the desired precision to
    % determine how many genes we need for each variable.
    
   
    % if the GPU is used create GPU arrays, preallocation 
    if use_GPU
        N_genes = gpuArray(zeros(size(lowerLimits)));
    else
        N_genes = zeros(size(lowerLimits));
    end

    % Determination of the number of genes for each variable
    for i=1:length(lowerLimits)
        N_genes(i)=round((log2((higherLimits(i)-lowerLimits(i))*10^precisions(i))+1 + log2((higherLimits(i)-lowerLimits(i))*10^precisions(i)+1))/2);
    end
    Total_N_genes = sum(N_genes);

    value = round(rand(n,Total_N_genes)); 

end