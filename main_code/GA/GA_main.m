%% Cleaning the Workspace
clear all;
close all;
hold off;
clc

%-----------------------------------------------------------------------
p = 100; % population size
c = 30; % number of pair of chromosomes to be crossovered
m = 30; % number of pair of chromosomes to be mutated
tg = 250; % total number of generations
lowerLimits = [0,30,0];
higherLimits = [3,60,3];
precisions = [3,3,3];
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
for i = 1:tg
    Cr = crossover(P,c);
    Mu = mutation(P,m);
    P(p+1:p+2*c,:) = Cr;
    P(p+2*c+1:p+2*c+m,:) = Mu;
    E = evaluation(P,lowerLimits,higherLimits,bits,@price_function);
    [P, S] = selection(P,E,p);
    K(i,1) = sum(S)/p;
    K(i,2) = S(1) % best
    plot(K(:,1),'b.'); drawnow
    hold on
    plot(K(:,2),'r.'); drawnow
end
