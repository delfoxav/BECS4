%% Genetic algorithm
% Implementation of the genetic algorithm, maximize the objective function

%% Cleaning the Workspace
clear;
close all;
clc

%-----------------------------------------------------------------------
p = 200; % population size
c = 20; % number of pair of chromosomes to be crossovered
m = 5; % number of pair of chromosomes to be mutated
e = 1; % number of elite individuals to select at each generation
total_generations = 500; % total number of generations
lowerLimits = [-1,-1,-1]; % the parameters were centrized arround -1 and 1
higherLimits = [1,1,1];
precisions = [4,4,4];
use_GPU = false; % select if the computation has to be done on the GPU or not
%-----------------------------------------------------------------------

figure
title('Blue average Red maximum')
xlabel('Generation')
ylabel('Objective Function Value')
hold on
[P, genes] = population(p, lowerLimits,higherLimits, precisions,use_GPU);

k = 0;
[x1,y1] = size(P);

%preallocating
if use_GPU
    K=gpuArray;
end
    
for i = 1:total_generations
    Cr = crossover(P,c,use_GPU); 
    Mu = mutation(P,m,use_GPU);
    P(p+1:p+2*c,:) = Cr;
    P(p+2*c+1:p+2*c+m,:) = Mu;
    E = evaluation(P,lowerLimits,higherLimits,genes,@objective_function,@price_function,@yield_check_function,use_GPU);
    [P, S] = selection(P,E,p,e,use_GPU);
    K(i,1) = sum(S)/p;
    if e ~= 0
        K(i,2) = S(1); % best
    end
    plot(i,K(i,1),'b.'); drawnow
    hold on
    if e ~= 0
        plot(i,K(i,2),'r.'); drawnow
    end
end
hold off;

% draw the Price function of the last population
figure
title('Price function last population')
xlabel('Individual')
ylabel('Cost Value [%]')
hold on
plot(evaluate_function(P,lowerLimits,higherLimits,genes,@price_function,use_GPU),'cyan')
hold off

% draw the yield function of the last population
figure
title('yield function last population')
xlabel('Individual')
ylabel('yield Value [%]')
hold on
plot(evaluate_function(P,lowerLimits,higherLimits,genes,@yield_check_function,use_GPU),'black')
hold off

% draw the objective function of the last population
figure
title('objective function last population')
xlabel('Individual')
ylabel('objective function Value')
hold on
plot(evaluate_function(P,lowerLimits,higherLimits,genes,@objective_function,use_GPU),'green')
hold off


% Get the best result
best_obj = max(S); %Should be at position 1 by definition but just in case
[row,col] = find(S == best_obj);
best_individual=P(col(1),:);
best_yield = evaluate_function(best_individual,lowerLimits,higherLimits,genes,@yield_check_function,use_GPU);
best_price = evaluate_function(best_individual,lowerLimits,higherLimits,genes,@price_function,use_GPU);
best_values = get_values(best_individual,lowerLimits,higherLimits,genes);

% rescale the values
best_values(1) = 3-(1-best_values(1))*3/2;
best_values(2) = 60-(1-best_values(2))*30/2;
best_values(3) = 3-(1-best_values(3))*3/2;




disp(sprintf('The highest value found of the objective function was %.4f, \n this value gave a yield of %.4f %% and the price reaction for this set of parameters is %.4f CHF \n The set of parameters are: x = %.4f mMol, y = %.4f °C, z = %.4f mMol',...
    best_obj,best_yield,best_price, best_values(1), best_values(2), best_values(3)))
