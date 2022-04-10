function [value1, value2] = selection(P,F,p,e,use_GPU)
%% Function to select the individuals to reproduce for the next generation
% value 1 are the genes set of the individuals selected, value 2 are the values of the objective function with the selected
% individuals

% P = Population
% F = fitness value
% p = population size
% e = number of elite individuals to select for the next generation
% use_GPU = define if the computation has to be performed using the GPU

% Checks the type of the inputs
    if ~isnumeric(P)
        error("P : Double expected but %s was given ",class(P));
    end
    if ~isnumeric(F)
        error("F : Double expected but %s was given ",class(F));
    end
    if ~isnumeric(p)
        error("p : Double expected but %s was given ",class(p));
    end
    if ~isnumeric(e)
        error("e : Double expected but %s was given ",class(e));
    end
    if ~islogical(use_GPU)
        error("use_GPU : boolean expected but %s was given " ,class(use_GPU));
    end

% Checks if p and e are positive or null
if p<=0
    error("population size must be higher than 0");
end
if e <0
    error("e cannot be lower than 0");
end

% if the GPU is used create GPU arrays, preallocation 
[X, Y] = size(P);
if use_GPU
    Y1 = zeros(p,Y);
    Fn = gpuArray;
else
    Y1 = zeros(p,Y);
end

% We check that no chromosome has a negative fitness, if it is the case we
% set its fitness to zero
for j = 1:length(F)
    if F(j)<0
        F(j) = 0;
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


D = F/sum(F); % Determine selection probability
E = cumsum(D); % Determine cumulative probability
rand_value = rand(1); % Generate a random number
k = 1;
l = e;
while l <= p-e 
    if rand_value <= E(k) % compare rand_value with the selection probability of each individuals (minus e individuals for the elite selection)
        Y1(l+1,:) = P(k,:); % add the selected individual at the end of Y1 
        Fn(l+1) = F(k);
        rand_value = rand(1); % get a new random value
        l = l +1;
        k = 1;
    else
        k= k +1;
    end
end
value1 = Y1;
value2 = Fn;
end