%clear and close all variables / plots

clear all;
close all;

% Define the interval and precision


encoding(-1,2,10^(-6),0.637197,2)

function binary_encoding = encoding(a,b,e,x,base)

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
    z = ((x-a)/(b-a))*(2^k -1)
    binary_encoding = dec2base(round(z),base)

end