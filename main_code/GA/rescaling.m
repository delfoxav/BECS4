function result = rescaling(min,max,value)
% rescale the value value in the [min,max] range
result = max-(1-value)*(max-min)/2;
