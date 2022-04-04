%% Cleaning the Workspace
clear all;
close all;
hold off;

%% Definition of the Function to optimize
% x = TOBECOMPLETED
% y = TOBECOMPLETED
% z = TOBECOMPLETED
price_func = @(x,y,z) 87.6 + 6.41*x + 2.53*y + 9.29*z + 3.39*x^2 - 16.64*y^2 -4.84*z^2 - 3.43*x*y - 3.63*y*z

%% Definition of the Constraints

% Temperature has to be between 30 and 60
% So Temp <= 60, then we can write Temp - 60 + a^2 = 0 for the first
% condition and consider a as another variable to minimize
Temp_constraint_1 = @(y,a) y - 60 + a.^2
% for the second condition, we have Temp >= 30, then we can write Temp + 30
% + b^2 = 0 and we consider b as new variable to minimize
Temp_constraint_2 = @(y,b) y + 30 + b.^2

% The concentration of catalyst has to be between 0 and 3
% So C_cat <= 3, then we write C_cat -3 + c^2 = 0 for the first condition
% and we consider c as a new variable to minimize
C_cat_constraint_1 = @(x,c) x -3 + c.^2
% for the second condition we have C_cat >=', the we write C_cat + d^2 = 0
% and we consider d as a new variable to minimize
C_cat_constraint_2 = @(x,d) x + d.^2

% We also need a yield of at least 60% TOBEDEFINED

%The concentration of reactant has to be higher than 0 (by definition),
%therefore we can add the following equation with e another variable to
%minimize
C_react_constraint = @(z,e) z + e.^2

%% Definition of the Lagrangian function
% Using the differents conditions we can define a Lagrangian function to
% optimize
Lag_func = @(x,y,z,a,b,c,d,e,l1,l2,l3,l4,l5) ...
    87.6 + 6.41*x + 2.53*y + 9.29*z + 3.39*x^2 - 16.64*y^2 -4.84*z^2 - 3.43*x*y - 3.63*y*z ...
    - l1*Temp_constraint_1(y,a) -l2*Temp_constraint_2(y,b) - l3*C_cat_constraint_1(x,c) ...
    - l4*C_cat_constraint_2(x,d) - l5*C_react_constrain(z,e)

%% Definition of the partial derivatives
% Even if the Lagrangian function is heavy, there is no difficulty in
% calculating the partial derivatives by hand. Therefore we opted for a
% analytical derivative calculation as it is less computing demanding than
% a numerical derivative determination
dx = @(x,y,l3,l4) 6.41+ 2*3.39*x  - 3.43*y - l3 - l4
dy = @(x,y,z,l1,l2) 2.53 - 2*16.64*y - 3.43*x - 3.63*z- l1 -l2
dz = @(y,z,l5) 9.29 -2*4.84*z - 3.63*y - l5
da = @(a,l1) - 2*l1*a
db = @(b,l2) - l2*2*b
dc = @(c,l3) - l3*2*c
dd = @(d,l4) - l4*2*d
de = @(e,l5) - l5*2*e
dl1 = @(a,y) - (y - 60 + a.^2)

