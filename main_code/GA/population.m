function [value,N_bits] = population(n, lowerLimits, higherLimits, precisions)
    % n = population size
    % lowerLimits = vector of lower bounds on the differents variables
    % higherLimits = vector of higher bounds on the different variables
    % precisions = vector of desired precisons for the different variables

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
        
    
    % In order to determine how many bits we need, we have to use the desired
    % range and precision of each variable.
    
    
    % We can then use the formula: 2^(m-1) < (upper limit - lower limit)*10^p <
    % 2^m-1 where m is the number of bits and p the desired precision (2) to
    % determine how many bits we need for each variable.
    
    % Determination of the number of bits for each variable
    N_bits = zeros(size(lowerLimits));
    for i=1:length(lowerLimits)
        N_bits(i)=round((log2((higherLimits(i)-lowerLimits(i))*10^precisions(i))+1 + log2((higherLimits(i)-lowerLimits(i))*10^precisions(i)+1))/2);
    end
    Total_N_bits = sum(N_bits);

    value = round(rand(n,Total_N_bits)); 

end