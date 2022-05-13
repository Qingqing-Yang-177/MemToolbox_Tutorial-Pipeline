%% Estimate the goodness of model fitting
% whether or not the model—with its best parameter values—provides a good 
% fit to the data. (focus on the last figure of MemFit)

% MemToolbox uses Markov Chain Monte Carlo (MCMC) to do model fitting. MCMC 
% samples parameter values in proportion to how well they describe the data 
% and how well they match the prior. 
clear all;
data = MemDataset(1);
fit = MemFit(data, StandardMixtureModel)

% figure 1
% Interactive figure, the predicted parameter / distribution, and the real
% data

% type 'y' when being asked:
% Would you like to see the tradeoffs
% between parameters, samples from the posterior
% distribution and a posterior predictive check? (y/n):

%% MCMC samples parameter values in proportion to how well they describe the data

% figure 2 
% shows  full posterior distribution for each parameter and a heat map for each 
% pair of parameters, showing how they covary. These plots are useful for diagnosing 
% correlations between parameters.

% On the diagonal are plots that show the posterior for an individual
% parameter — e.g., the distribution for guess rate (g) 
% the data make us quite confident that the guess rate is between 0.08 and 0.11.

% On the off-diagonal are the correlations between the parameters – for example, the 
% top right axis shows guess rate (y-axis) plotted against standard deviation (x-axis). 
% The off-diagonals show heatmaps to visualize correlations between parameters. For 
% example, in the standard Zhang & Luck (2008) mixture model, there is a correlation 
% between the guess rate parameter (g) and the standard deviation parameter (sd). The 
% data is generally equally consistent with a slightly higher guess rate and slightly lower 
% standard deviation

% Figure 3 
% shows the parameters of the model in a parallel 
% coordinates plot (http://en.wikipedia.org/wiki/Parallel_coordinates),
% along with a visualization of the parameters fit to the data.
% Each line on the parallel coordinates plot 
% corresponds to a reasonable set of parameters for fitting the data
% more likely parameter combinations get darker colors, 
% and less likely parameter values appear more gray

% The negative correlation between the parameters of this particular model is 
% indicated by the fact that the lines tend to have slopes that differ from zero (e.g., high 
% values on one parameter give low values on the other, and vice versa). A positive 
% correlation would be shown by the lines being mostly parallel between the left and right 
% sides, meaning high values of one parameter give high values of the other. 

%% how well the best parameter samples by MCMC match the prior.
% Figure 4
% shows the posterior predictive distribution—the model’s residual. The former 
% two plots provide ways of examining which parameter values of the model provide the 
% best fits. 
% This figure instead shows whether or not the model—with its best parameter 
% values—provides a good fit to the data. In particular, we simulate ‘fake’ data from the 
% posterior of the model and ask whether it looks like the real data. If the model provides a 
% good fit, then the data that is simulated using the best fit parameters (the posterior) will
% closely resemble the actual data. 

% The top of the plot shows the data in black, and the simulated data in green. 
% They should be on top of each other if the model provides a good fit. 
% The bottom of the plot shows the difference between the two, 
% both on average (grey line) and with 95% confidence intervals (grey shading). 
% Any regions where the gray shading does not include zero are 
% regions where the model is systematically incorrect in its predictions