function value = evaluate_result(lowerLimits, higherLimits, genes, func)

 tmp = zeros(size(lowerLimits));
    values = zeros(size(lowerLimits));
    disp(x1)
    for i = 1: x1
        for j = 1: length(genes)

            tmp(1) = bin2dec(num2str(P(i,1:genes(1)))); % convert the bin set back to decimal number
            values(1) = lowerLimits(1) + tmp(1) *(higherLimits(1) - lowerLimits(1))/(2^(genes(1))-1); % scale the number in the value range
            tmp(2) = bin2dec(num2str(P(i,genes(1)+1:genes(1)+genes(2)))); % convert the bin set back to decimal number
            values(2) = lowerLimits(1) + tmp(2) *(higherLimits(2) - lowerLimits(2))/(2^(genes(2))-1); % scale the number in the value range
            tmp(3) = bin2dec(num2str(P(i,genes(1)+genes(2)+1:genes(1)+genes(2)+genes(3)))); % convert the bin set back to decimal number
            values(3) = lowerLimits(3) + tmp(3) *(higherLimits(3) - lowerLimits(3))/(2^(genes(3))-1); % scale the number in the value range
        
        end
        H(1,i) = func(values);
    end
    value = H;