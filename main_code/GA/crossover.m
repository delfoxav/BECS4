function value = recombination(P, n,n_cutting,use_GPU)
%% Recombination of the genetic algorithm 
% Implementation of a k point recombination

    % P = population
    % n = number of chromosomes to be crossedover
    % n = number of cutting point
    % use_GPU = define if the computation has to be performed using the GPU
    
    % Checks the type of the inputs
    if ~isnumeric(P)
        error("P : Double expected but %s was given ",class(P));
    end
    if ~isnumeric(n)
        error("n : Double expected but %s was given ",class(n));
    end
    if ~isnumeric(n_cutting)
        error("n_cutting: Double expected but %s was given",class(n_cutting));
    end

    if ~islogical(use_GPU)
        error("use_GPU : boolean expected but %s was given " ,class(use_GPU));
    end

% Checks if n is positve
    if n<0
        error("n : must be positve")
    end
    if n_cutting<0
        error("n : must be positve")
    end

    cutting_point = 0; % index of the cutting point
    parents_index = 0; % index of the 2 parents chosen
    
    [population_size  nb_of_genes] = size(P);
    
    % initialize the output matrix (preallocation of the memory)
    if use_GPU
        Z = gpuArray(zeros(2*n,nb_of_genes)); 
    else
        Z = zeros(2*n,nb_of_genes);
    end

    for i = 1:n
        parents_index = randi(population_size,1,2); % select randomly two parents
        % Assure that we are note taking twice the same parent
        while parents_index(1)==parents_index(2)
            parents_index = randi(population_size,1,2);
        end
        Parent_1 = P(parents_index(1),:); % First_parent
        Parent_2 = P(parents_index(2),:); % Second_parent

        for j = 1:n_cutting % loop over the number of cutting to perform a k point recombination

            cutting_point = 1+randi(nb_of_genes-1); % random cutting point
            % Invert the genes after the cutting point of parent 1 and
            % parent 2
            [Parent_1(1,cutting_point:nb_of_genes),Parent_2(1,cutting_point:nb_of_genes)] = deal(Parent_2(1,cutting_point:nb_of_genes),Parent_1(1,cutting_point:nb_of_genes));
        
        end

        Z(2*i-1,:) = Parent_1; % add the recombined Parent 1 to the output matrix
        Z(2*i,:) = Parent_2; % add the recombined Parent 2 to the output matrix
    end
    value = Z; % return the recombination
