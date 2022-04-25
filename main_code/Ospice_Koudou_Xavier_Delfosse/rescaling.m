% Lecture: BECS4: Optimisation Methods
% work: Optimization of a chemical reaction on a catalytic bed
% date: 25.04.2022
% authors: Ospice Koudou % Xavier Delfosse

function result = rescaling(min,max,value)
% rescale the value value in the [min,max] range

if ~isnumeric(min)
    error("min: Double expected but %s was given ",class(min))
end

if ~isnumeric(max)
    error("max: Double expected but %s was given ",class(max))
end

if ~isnumeric(value)
    error("value: Double expected but %s was given ",class(value))
end

if (max<min)
    error("max should be higher than min")
end

result = max-(1-value)*(max-min)/2;
