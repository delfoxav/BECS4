function value = mutation(P, n, use_GPU)
%% Mutation mechanism of the Genetic algoritm
% Mutates one random gene in one random parent per mutation

% P = population (output of Population.m)
% n = number of genes to be mutated
% use_GPU = define if the computation has to be performed using the GPU

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