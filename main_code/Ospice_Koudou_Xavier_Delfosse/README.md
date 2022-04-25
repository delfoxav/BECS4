% Lecture: BECS4: Optimisation Methods
% work: Optimization of a chemical reaction on a catalytic bed
% date: 18.04.2022
% authors: Ospice Koudou % Xavier Delfosse

BECS_4 Project Implementation of an Optimization method with a Chemistry based experiment

The goal of this work was to produce a chemical molécule for a customer. The chemical reaction was perfomed on a catalytic bed in microreactor.
Our goal was to lead an efficient reaction with a good yield and a low cost.

Therefore, multiple parameters with potential influences on the yield were selected as: concentration of catalyst [%/mMol], concentration of main reagent [mol/L],
temperature [°C], feed rate [L/min] and mixing rate [RPM]. Thanks to a DOE and the required Anova analysis and normal probability plot, the actual effect of these
parameters and their interactions with each other on the chemical reaction were identified and thus, only three of them and their interactions were kept to define the objective function:

- Concentration of main reagent [mol/L]
- Concentration of catalyst [ % / mmol]
- temperature [°C]

Futhermore, the optimization was subject to the following constraints:

- The reaction yield has to be higher than 60% 
- Concentration of catalyst has to be between 0 and 3 mMol
- Concentration of reagent has to be between 0 and 3 mMol
- Temperature has to be between 30 and 60°C
- Heating cost is 0.20 CHF per °C
- reagent cost is 22 CHF / mol/L
- catalyst cost is 10 CHF / mmol
- Spend maximum 1 CHF per yield percentage

- all three parameters where reduced centred between [-1 and 1]

The following equation was build to represent the yield:

g = 91.99 + 2.81*x + -1.099*y +2.81*z - 7.99*x^2 - 16.64*y^2 -7.99*z^2 - 5.34*x*y - 5.34*y*z;

and the following equation to represent the cost:

h = 10 * (3-(1-x)*3/2) + 0.2*(60-(1-y)*30/2) + 22*(3-(1-z)*3/2);

finally the objective function was defined as:

f = g-h

with:

x = catalyst concentration [mmol/L]
y = Temperature [°C]
z = reagent concentration [mol/L]

