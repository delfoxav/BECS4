% Lecture: BECS4: Optimisation Methods
% work: Optimization of a chemical reaction on a catalytic bed
% date: 25.04.2022
% authors: Ospice Koudou % Xavier Delfosse


function value = mutation(P, n, use_GPU)
%% Mutation mechanism of the Genetic algoritm
% Mutates one random gene in one random parent per mutation

% P = population (output of Population.m)
% n = number of genes to be mutated
% use_GPU = define if the computation has to be performed using the GPU


% Checks the type of the inputs
    if ~isnumeric(P)
        error("P : Double expected but %s was given ",class(P));
    end
    if ~isnumeric(n)
        error("n : Double expected but %s was given ",class(n));
    end
    if ~islogical(use_GPU)
        error("use_GPU : boolean expected but %s was given " ,class(use_GPU));
    end

% Checks if n is positve
    if n<0
        error("n : must be positve")
    end



[population_size, nb_of_genes] = size(P);

% if the GPU is used create GPU arrays, preallocation 
if use_GPU
    Z = gpuArray(zeros(n,nb_of_genes));

else
    Z = zeros(n,nb_of_genes);
end

for i = 1:n 
    % Choose a random parent
    parent_index = randi(population_size);
    parent = P(parent_index,:); % random parent
    gene_index = randi(nb_of_genes); % choose a random gene
    parent(gene_index) = ~parent(gene_index); % invert the mutation bit
    Z(i,:)=parent; % add the mutated parent to the output matrix
end

value = Z; % return the mutated individuals