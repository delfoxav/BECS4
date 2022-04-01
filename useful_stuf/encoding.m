
function output = encoding(a,b,e,x,base)

%% Compute the binary encoding of the value x in the interval [a,b] with
%% precision e. Return the binary result.
% a: lowest value of the interval
% b: highest value of the interval
% e: precision of the encoding
% x: value to encode
% base: base of the encoding
    
 
    
    % split the interval
    
    
    k = round(log2((b-a)/e));
    
    % Encoding of x
    z = ((x-a)/(b-a))*(2^k -1);
    output = dec2base(floor(z),base);

end