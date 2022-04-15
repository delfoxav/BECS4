%% Genetic algorithm
% Implementation of the genetic algorithm, maximize the objective function

%% Cleaning the Workspace
clear;
close all;
clc

%% Definition of the Hyperparameters
%-----------------------------------------------------------------------
p = 200; % population size
c = 20; % number of pair of chromosomes to be crossovered
m = 5; % number of pair of chromosomes to be mutated
e = 1; % number of elite individuals to select at each generation
total_generations = 500; % total number of generations
n_cut = 1;
lowerLimits = [-1,-1,-1]; % the parameters were centrized arround -1 and 1
higherLimits = [1,1,1];
precisions = [4,2,6];
use_GPU = false; % select if the computation has to be done on the GPU or not 
ILM_DHC = true; % Select if a Dynamic Increasing of Low Mutation/Decreasing of High Crossover should be applied
realtime = false; % Select if the graph should be display in real time or not. Setting this value to false will drastically reduce the computation time.
%-----------------------------------------------------------------------

%% Creation of the live plot
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
tic;
p1 = plot(0,0,'.b','DisplayName','average of generation');
p2 = plot(0,0,'.r','DisplayName','maximum of generation');
%% Running of the algorithm
    
for i = 1:total_generations
    
    % apply ILM_DHC
    if ILM_DHC
        % maximize the number of mutation to 5% of the population
        if m < p*5/100
            m = floor((i/total_generations)*p);
        end
         % maximize the number of crossover to 70% of the population
         if c > p*70/100
            c = floor((0.7 - (i/total_generations))*p);
         end
    end

    Cr = crossover(P,c,n_cut,use_GPU); % perform the crossovers 
    Mu = mutation(P,m,use_GPU); % perform the mutation
    P(p+1:p+2*c,:) = Cr; % add the crossovers at the end of population
    P(p+2*c+1:p+2*c+m,:) = Mu; % add the mutation at the end of population
    E = evaluation(P,lowerLimits,higherLimits,genes,@objective_function,@price_function,@yield_check_function,use_GPU); % evaluate the cost function
    [P, S] = selection(P,E,p,e,use_GPU); % select the individuals of the population reduce the population to a size of p
    K(i,1) = sum(S)/p; % compute the average result of the generation
    if e ~= 0
        K(i,2) = S(1); % store the best individual of the generation
    end
    if realtime
        set(p1, 'XData', 1:i, 'YData',K(:,1)); drawnow
    end
    hold on;
    if e ~= 0
        if realtime
            set(p2, 'XData', 1:i, 'YData',K(:,2)); drawnow
        end
    end
    legend('Location','southeast','AutoUpdate','off'); % Change the position of the legend and stop updating it
    
end

%Draw the evolution at the end of the computation
if ~realtime
    set(p1, 'XData', 1:i, 'YData',K(:,1));
     set(p2, 'XData', 1:i, 'YData',K(:,2));
end

hold off;


%% Draw the output graphs

% draw the Price function of the last population
figure('Name','Price, Yield and Objective function of the last population');
subplot(2,2,1);
plot(evaluate_function(P,lowerLimits,higherLimits,genes,@price_function,use_GPU),'cyan');
title('Price function last population');
xlabel('Individual');
ylabel('Cost Value [CHF]');


% draw the yield function of the last population
subplot(2,2,2);
plot(evaluate_function(P,lowerLimits,higherLimits,genes,@yield_check_function,use_GPU),'black');
title('yield function last population');
xlabel('Individual');
ylabel('yield Value [%]');
hold on;
yline(60,'red');
hold off;

subplot(2,2,[3,4]);
plot(evaluate_function(P,lowerLimits,higherLimits,genes,@objective_function,use_GPU),'green');
title('objective function last population');
xlabel('Individual');
ylabel('objective function Value');

%% Show the results in the command line

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
toc;