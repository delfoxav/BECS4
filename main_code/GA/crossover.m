function value = recombination(P, n)
%% Recombination of the genetic algorithm 
% only a one-point recombination was implemented here

    % P = population
    % n = number of chromosomes to be crossedover
    cutting_point = 0; % index of the cutting point
    parents_index = 0; % index of the 2 parents chosen
    [population_size  nb_of_genes] = size(P);
    Z = zeros(2*n,nb_of_genes); % initialize the output matrix (preallocation of the memory)
    for i = 1:n
        parents_index = randi(population_size,1,2); % select randomly two parents
        % Assure that we are note taking twice the same parent
        while parents_index(1)==parents_index(2)
            parents_index = randi(population_size,1,2);
        end
        Parent_1 = P(parents_index(1),:); % First_parent
        Parent_2 = P(parents_index(2),:); % Second_parent
        cutting_point = 1+randi(nb_of_genes-1); % random cutting point
        % Invert the the genes after the cutting point of parent 1 and
        % parent 2
        [Parent_1(1,cutting_point:nb_of_genes),Parent_2(1,cutting_point:nb_of_genes)] = deal(Parent_2(1,cutting_point:nb_of_genes),Parent_1(1,cutting_point:nb_of_genes));
        
        Z(2*i-1,:) = Parent_1; % add the recombined Parent 1 to the output matrix
        Z(2*i,:) = Parent_2; % add the recombined Parent 2 to the output matrix
    end
    value = Z; % return the recombination
