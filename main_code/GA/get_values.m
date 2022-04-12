function values = get_values(P, lowerLimits, higherLimits, genes)
%% Conversion of binary values to decimal values
    % P = population
    % lowerLimits = vector of the lower bound on each variable
    % higherLimits = vector of the higher bound on each variable
    % genes = vector of genes used for each variable

    result=[];
    [x1,y1] = size(P);
    tmp = zeros(size(lowerLimits)); %preallocation
    values = zeros(size(lowerLimits)); %preallocation
    
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
    end
    
