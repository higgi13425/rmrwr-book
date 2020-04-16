# Power calculations for tofa inpatient study
# examples from
# http://powerandsamplesize.com/Calculators/Compare-2-Proportions/2-Sample-Equality

pA=0.50 # proportion arm/group A
pB=0.80 #proportion group B
kappa=2 # ratio between group A/ group B assignment
alpha=0.05
beta=0.20 # beta = 1-power
(nB=(pA*(1-pA)/kappa+pB*(1-pB))*((qnorm(1-alpha/2)+qnorm(1-beta))/(pA-pB))^2)
ceiling(nB) # number in group B
kappa * ceiling(nB) # number in group A
z=(pA-pB)/sqrt(pA*(1-pA)/nB/kappa+pB*(1-pB)/nB)
(Power=pnorm(z-qnorm(1-alpha/2))+pnorm(-z-qnorm(1-alpha/2)))

pA=0.60 # proportion arm/group A
pB=0.95 #proportion group B
kappa=2 # ratio between group A/ group B assignment
alpha=0.05
beta=0.20 # beta = 1-power
(nB=(pA*(1-pA)/kappa+pB*(1-pB))*((qnorm(1-alpha/2)+qnorm(1-beta))/(pA-pB))^2)
ceiling(nB) # number in group B
kappa * ceiling(nB) # number in group A
z=(pA-pB)/sqrt(pA*(1-pA)/nB/kappa+pB*(1-pB)/nB)
(Power=pnorm(z-qnorm(1-alpha/2))+pnorm(-z-qnorm(1-alpha/2)))

pA=0.65 # proportion arm/group A
pB=0.90 #proportion group B
kappa=2 # ratio between group A/ group B assignment
alpha=0.05
beta=0.20 # beta = 1-power
(nB=(pA*(1-pA)/kappa+pB*(1-pB))*((qnorm(1-alpha/2)+qnorm(1-beta))/(pA-pB))^2)
ceiling(nB) # number in group B
kappa * ceiling(nB) # number in group A
z=(pA-pB)/sqrt(pA*(1-pA)/nB/kappa+pB*(1-pB)/nB)
(Power=pnorm(z-qnorm(1-alpha/2))+pnorm(-z-qnorm(1-alpha/2)))

pA=0.60 # proportion arm/group A
pB=0.85 #proportion group B
kappa=2 # ratio between group A/ group B assignment
alpha=0.05
beta=0.20 # beta = 1-power
(nB=(pA*(1-pA)/kappa+pB*(1-pB))*((qnorm(1-alpha/2)+qnorm(1-beta))/(pA-pB))^2)
ceiling(nB) # number in group B
kappa * ceiling(nB) # number in group A
z=(pA-pB)/sqrt(pA*(1-pA)/nB/kappa+pB*(1-pB)/nB)
(Power=pnorm(z-qnorm(1-alpha/2))+pnorm(-z-qnorm(1-alpha/2)))

pA=0.40 # proportion arm/group A
pB=0.70 #proportion group B
kappa=2 # ratio between group A/ group B assignment
alpha=0.05
beta=0.20 # beta = 1-power
(nB=(pA*(1-pA)/kappa+pB*(1-pB))*((qnorm(1-alpha/2)+qnorm(1-beta))/(pA-pB))^2)
ceiling(nB) # number in group B
kappa * ceiling(nB) # number in group A
z=(pA-pB)/sqrt(pA*(1-pA)/nB/kappa+pB*(1-pB)/nB)
(Power=pnorm(z-qnorm(1-alpha/2))+pnorm(-z-qnorm(1-alpha/2)))

