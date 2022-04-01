

function output = binary2gray(binary)

%% Convert a binary code to graycode
% both binary and gray will have the same MSB, then we perform a xor over
% the previous bit and the bit we are interested in to get the according
% gray value
    
    output =[binary(1)];
    
    for i=2:strlength(binary)
        tmp =output(i-1);
            output=[output,num2str(double(xor(tmp,binary(i))))];
    end

end