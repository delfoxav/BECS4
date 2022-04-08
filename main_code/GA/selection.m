function [value1, value2] = selection(P,F,p,e)
% P = Population
% F = fitness value
% p = population size
% e = number of elite individuals to select for the next generation
[X, Y] = size(P);
Y1 = zeros(p,Y);

% We check that no chromosome has a negative fitness, if it is the case we
% set its fitness to zero
for j = 1:length(F)
    if F(j)<0
        F(j) = 0
    end
end

% elite selection

for i = 1:e
    [r1, c1] = find(F == max(F)); % find the individual with the best result
    Y1(i,:) = P(max(c1),:); % add the genes of the best individuals to the output set
    P(max(c1),:) = []; % remove the genes of the individuals with the best result from the population
    Fn(i) = F(max(c1)); % add the result of the best individual to a best results array
    F(:,max(c1)) = []; % remove the individual with the best result from the input set
end


%%%%%%%%%%%%%%%%%%%%%%%%CONTINUE ICI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
value2 = Fn;
end