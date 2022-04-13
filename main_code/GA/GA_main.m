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
precisions = [4,2,6];
use_GPU = false; % select if the computation has to be done on the GPU or not
ILM_DHC = true; % Select if a Dynamic Increasing of Low Mutation/Decreasing of High Crossover should be applied
%-----------------------------------------------------------------------

figure('Name','Genetic Algorithm training')
title('Genetic Algorithm training')
xlabel('Generation')
ylabel('Objective Function Value')
legend('-DynamicLegend');
hold on
[P, genes] = population(p, lowerLimits,higherLimits, precisions,use_GPU);

k = 0;
[x1,y1] = size(P);

%preallocating
if use_GPU
    K=gpuArray;
end
    
for i = 1:total_generations
    
    % apply ILM_DHC
    if ILM_DHC
        % maximize the number of mutation to 5% of the population
        if m < p*5/100
            m = floor((i/total_generations)*p)
        end
        c = floor((1 - (i/total_generations))*p)
    end

    Cr = crossover(P,c,use_GPU); % perform the crossovers 
    Mu = mutation(P,m,use_GPU); % perform the mutation
    P(p+1:p+2*c,:) = Cr; % add the crossovers to the population
    P(p+2*c+1:p+2*c+m,:) = Mu; % add the mutation to the population
    E = evaluation(P,lowerLimits,higherLimits,genes,@objective_function,@price_function,@yield_check_function,use_GPU); % evaluate the cost function
    [P, S] = selection(P,E,p,e,use_GPU); % select the individuals of the population
    K(i,1) = sum(S)/p; % compute the average result of the generation
    if e ~= 0
        K(i,2) = S(1); % store the best individual of the generation
    end
    plot(K(:,1),'b.','DisplayName','average of generation'); drawnow
    hold on
    if e ~= 0
        plot(K(:,2),'r.','DisplayName','maximum of generation'); drawnow
    end
    legend('Location','southeast','AutoUpdate','off'); % Change the position of the legend and stop updating it
    
end
%legend('average','maximum')
hold off;

% draw the Price function of the last population
figure('Name','Price function last population')
title('Price function last population')
xlabel('Individual')
ylabel('Cost Value [CHF]')
hold on
plot(evaluate_function(P,lowerLimits,higherLimits,genes,@price_function,use_GPU),'cyan')
hold off

% draw the yield function of the last population
figure('Name','yield function last population')
title('yield function last population')
xlabel('Individual')
ylabel('yield Value [%]')
hold on
plot(evaluate_function(P,lowerLimits,higherLimits,genes,@yield_check_function,use_GPU),'black')
hold off

% draw the objective function of the last population
figure('Name','objective function last population')
title('objective function last population')
xlabel('Individual')
ylabel('objective function Value')
hold on
plot(evaluate_function(P,lowerLimits,higherLimits,genes,@objective_function,use_GPU),'green')
hold off


% Get the best result
best_obj = max(S); %Should be at position 1 but isn't the case if no elite individuals are stored
[row,col] = find(S == best_obj); %Should be at position 1 by definition but just in case
best_individual=P(col(1),:);
best_yield = evaluate_function(best_individual,lowerLimits,higherLimits,genes,@yield_check_function,use_GPU);
best_price = evaluate_function(best_individual,lowerLimits,higherLimits,genes,@price_function,use_GPU);
best_values = get_values(best_individual,lowerLimits,higherLimits,genes);

% rescale the values
best_values(1) = rescaling(0,3,best_values(1));
best_values(2) = rescaling(30,60,best_values(2));
best_values(3) = rescaling(0,3,best_values(3));

%Create Output text
text = ['The highest value found of the objective function was %.2f,' ...
    ' \n this value gave a yield of %.2f %% and the price reaction for this' ...
    ' set of parameters is %.2f CHF \n The set of parameters are:' ...
    ' x = %.',num2str(precisions(1)),'f mMol, y = %.',num2str(precisions(2)),'f' ...
    ' °C, z = %.',num2str(precisions(3)),'f mMol. \n'];

fprintf(text, best_obj,best_yield,best_price, best_values(1), best_values(2), best_values(3));
