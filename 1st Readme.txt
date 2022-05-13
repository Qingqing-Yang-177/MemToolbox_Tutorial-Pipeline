Adam et al. (2017) sample paper which utilized the Mixture model and Percision model.
Aspen et aL (2018) sample paper which utilized the Proportional model and Flexible model for resource allocation.

Paper.pdf (please do read it after this file.)
a brief but comprehensive introducation of funtcions in memtoolbox.

Tutuorial.pdf 
is the official tutuorial, really useful. if time primitted, read this tutuorial and the paper.pdf is the best choice.
Demo 5: Model comparison
Demo 11: Fitting models that require data from multiple set sizes
Demo 12: Analyzing multiple subjects


The tutuorial made by Qingqing Yang:
(also a process to utilize the moxture model:
(and my plan is to grasp the following functions by MemToolbox
( mixture model with precision SD, guess rate G, and capacity K; 
( variable precision model with jbar resource
	1. T1_Setup: Install and Setup;
	2. Get the error distributions for each set size for each subject, mean and variability (Adam et al., (2017) used CircStat toolbox in Matlab)
	3. T2_Modeling: Fit the error distribution by Mixture model
	    the mixture model fits response errors with a mixture of two distributions:
		a Von Mises distribution (circular normal). the dispersion is the precision parameter, sd (in degree). 
		a uniform distribution. contribution to the error distribution is the guessing parameter, g (0-1), the “proportion of guesses”. 
 	    	the capacity. 
	4. T3_Compare Parameters: for multiple subjects as in one population, comparing the parameters in different set sizes.
	5. T4_Model Fitting: Compare the fitting of the model by either log likelihood, AIC, AICc, BIC, Bayes factor (and posterior odds of the models) and DIC.
	


In the MemToolbox:
(for each folder, see Contents.m to view the instructions)
	MemFit.m            - a general purpose fitting tool
	Setup.m             - install MemToolbox to Matlab PATH
	MemTutorial         - a walkthrough of the toolbox
	MemModels           - models of working memory from the literature
	MemData             - real and simulated data sets
	MemFitting          - tools to fit models to data
	MemModelComparison  - tools to compare the ability of models to fit the data
	MemPlots            - visualization tools
	MemUtilities        - internal helper functions
	GeneralHelpers      - helper functions that might be useful elsewhere
	MemTests            - scripts that test toolbox functionality