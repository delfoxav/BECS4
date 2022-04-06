function [value1, value2] = selection(P,F,p)
% P = Population
% F = fitness value
% p = population size
[X, Y] = size(P);
Y1 = zeros(p,Y);
F = F + 10 % adding 10 ensure no chromosome has negative fitness
% elite selection
e = 3;
for i = 1:e
    [r1, c1] = find(F == max(F));
    Y1(i,:) = P(max(c1),:);
    P(max(c1),:) = [];
    Fn(i) = F(max(c1));
    F(:,max(c1)) = [];
end

D = F/sum(F); % Determine selection probability
E = cumsum(D); % Determine cumulative probability
N = rand(1); % Generate a vector containing normalized random numbers
d1 = 1;
d2 = e;
while d2 <= p-e
    if N <= E(d1)
        Y1(d2+1,:) = P(d1,:);
        Fn(d2+1) = F(d1);
        N = rand(1);
        d2 = d2 +1;
        d1 = 1;
    else
        d1 = d1 +1;
    end
end
value1 = Y1;
value2 = Fn-10;
end