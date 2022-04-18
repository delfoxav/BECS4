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


Le projet globalement consiste A produire une molécule pour un client. La réaction se fait sur un lit catalytic dans un microréacteur
Nous en tant sous-traitant, c'est de conduire une réaction efficace qui donne un bon rendement (minimum 60% exigé par le client)
mais qui ne coute pas chère.
Le but donc est d'optimiser le profit (coût en CHF) de cette reaction avec un rendement qui respect les exigences. 
Pour cela, nous avions selectionné différent paramètres qui pourraient potentiellement influencer le système à savoir :
la concentration du catalyseur (% /mmol),la concentration du reactif principal (mol/l), la température (°C), 
le feed rate (l/min)et le mixing rate (rpm).

les critères sont :
- Depenser 1 CHF / % de rendement pour 60% minimum 
- Coût du catalyst : 10 CHF / mmol de catalyst
- Coût de chauffage : 0.20 CHF par °C au dela de la Temp. ambiante
- Coût du réactif : 22 CHF / mol /l
- Température entre 30 et 60 °C
- concentration de catalyseur entre 0 et 3 mMol
- concentration de réactif entre 0 et 3 Mol/L
Avant de contruire notre model, on a effectué un DoE afin d'obtenir des data necessaires. Dans le DoE, on etudier l'effet des paramètres 
sur le système mais aussi l'effet de leur intéraction. Une analyse Anova et un normal probability plot nous ont permis d'identifier 
les paramètres différents qui ont une influence. Ce sont :
- La concentration du catalyst, la température, la concentration du réactif, intéraction (Cat-Temp) et intéraction (Conc-temp.)
Le Modèle ci-dessous  

f = 87.6 + 6.41*x+ 2.53*y + 9.29*z + 3.39*x^2 + -16.64*y^2 + -4.84*z^2 + -3.43*x*y + -3.63*y*z



x = concentration du catalyst
y = Température
z = Concentration du réactif

ATTENTION les inputs doivent être centrés entre -1 et 1

rendement_func = @(x,y,z) 91.99 + 2.81.*x+ -1.099.*y +2.81.*z - 7.99.*x.*x - 16.64.*y.*y -7.99.*z.*z  - 5.34 .*x.*y - 5.34 .* y .* z

cout = @(x,y,z) 10 .* (3-(1-x).*3/2) + 0.2 .* (60-(1-y)*30/2) + 22.*(3-(1-z).*3/2)

