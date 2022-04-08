%% Genetic algorithm
% Implementation of the genetic algorithm, maximize the objective function

%% Cleaning the Workspace
clear all;
close all;
hold off;
clc

%-----------------------------------------------------------------------
p = 100; % population size
c = 20; % number of pair of chromosomes to be crossovered
m = 50; % number of pair of chromosomes to be mutated
e = 0; % number of elite individuals to select at each generation
total_generations = 500; % total number of generations
lowerLimits = [-1,-1,-1];
higherLimits = [1,1,1];
precisions = [4,4,4];
%-----------------------------------------------------------------------

figure
title('Blue average Red maximum')
xlabel('Generation')
ylabel('Objective Function Value')
hold on
[P, bits] = population(p, lowerLimits,higherLimits, precisions);
k = 0;
[x1,y1] = size(P);
P1 = 0;
for i = 1:total_generations
    Cr = crossover(P,c); 
    Mu = mutation(P,m);
    P(p+1:p+2*c,:) = Cr;
    P(p+2*c+1:p+2*c+m,:) = Mu;
    E = evaluation(P,lowerLimits,higherLimits,bits,@price_function);
    [P, S] = selection(P,E,p,e);
    K(i,1) = sum(S)/p;
    K(i,2) = S(1) % best
    plot(K(:,1),'b.'); drawnow
    hold on
    plot(K(:,2),'r.'); drawnow
end