

function output = gray2binary(gray)

%% Convert a gray code to binary
    
    output =[gray(1)];
    
    for i=2:strlength(gray)
        tmp =output(i-1);
        if tmp == gray(i)
            output=[output,'0'];
        else 
            output=[output,'1'];
        end
    end

end