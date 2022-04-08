function [index, individual] = WheelOfFortune(individuals)
% individuals: Distribution of the individuals
    
    % Checks the input
    if ~isnumeric(individuals)
        err("n : Double expect but %s was given ",class(individuals))
    end
    
    sumfitness = sum(individuals);
    marker = rand()*sumfitness;
    sumIndiv = 0;
    index = 0;
    while sumIndiv < marker && index <=length(individuals)
        index = index + 1;
        sumIndiv = sumIndiv + individuals(index);
        
    end
    individual = individuals(index)
end