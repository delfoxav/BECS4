# BECS4
BECS_4 Project Implementation of an Optimization method with a Chemistry based experiment
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
- concentration de réactif entre 0 et 3 mMol
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
