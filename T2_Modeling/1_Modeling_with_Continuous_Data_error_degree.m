%% Modeling with continuous data(error_degree)
% to start the tutorial we will focus on only one of these tasks, a continuous partial 
% report task with colors. In such a task, observers see the stimulus display, and then after a delay are 
% asked to report the exact color of a single item. 
% Error is quantified as the distance between the response and the correct answer, in degrees on the color wheel.
% The simplest way to use the MemToolbox with such data is through MemFit, a function that houses much of the toolbox’s functionality under one roof. To use MemFit with 
% continuous report data, first specify your data as a vector of errors, one for each trial, in 
% units of degrees on the color wheel. These errors should fall between –180 and 180.
c=mfilename('fullpath')
%% StandardMixtureModel with MAP
% To use MemFit with continuous report data, first specify your data as a 
% vector of response errors, one for each trial, e.g. in units of degrees 
% on the color wheel between –180 and 180.

% Output:
% return the maximum a posteriori and credible intervals of the model 
% parameter values inferred from the data.
% 
% the dispersion is the precision parameter, sd (in degree).
% Bigger sd means more dispersed distribution
% guessing parameter, g (0-1), the “proportion of guesses”. 
% higher g means lower biggest value at the center of error distribution

clear all;
errors = [-89, 29, -2, 6, -16, 65, 43, -12, 10, 0, 178, -42, 52, 1, -2];
MemFit(errors);

%% StandardMixtureModel with the maximum likelihood parameters 
% Output:
% Return the Maximum likelihood parameters for this observer’s data
% No model passed in. Assuming StandardMixtureModel().
% ans =
%     0.5267    7.8608
clear all;
errors = [-89, 29, -2, 6, -16, 65, 43, -12, 10, 0, 178, -42, 52, 1, -2];
MLE(errors);

% or define the model:
model = StandardMixtureModel();
data.errors = [-89, 29, -2, 6, -16, 65, 43, -12, 10, 0, 178, -42, 52, 1, -2];
fit = MLE(data, model)

%% StandardMixtureModel with further understanding
% More importance of data structure could be viewed at swapping model
% section below
% Chains refers to the “chains” of Markov Chain Monte Carlo, which you can read about on 
% Wikipedia (http://en.wikipedia.org/wiki/Markov_chain_Monte_Carlo). The default MCMC 
% algorithm used by MemToolbox uses multiple chains whose starting values are specified 
% in the model file (and modifiable), and it continues running them until they have 
% converged to a similar range of parameters. Every 200 steps, the toolbox will update you 
% on its progress:
% figure 1
% Interactive figure, the predicted parameter/distribution, and the real
% data. it lets you manipulate the values of the model parameters and see the 
% impact on the predicted distribution of data. As you change the values, 
% notice that the prediction line changes color — it gets less saturated 
% (close to grey) as you choose values that make the data less likely.
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
% The data is generally equally consistent with a slightly higher guess rate and slightly 
% lower standard deviation
% Figure 3 
% shows the parameters of the model in a parallel coordinates plot 
% (http://en.wikipedia.org/wiki/Parallel_coordinates),
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

clear all;
data = MemDataset(1);
fit = MemFit(data, StandardMixtureModel)


%% StandardMixtureModel() WithBias
% One of the available models extends the standard mixture by allowing a 
% bias term, such that the central tendency of the data isn’t fixed at zero. 
model = WithBias(StandardMixtureModel());
errors = [-89, 29, -2, 6, -16, 65, 43, -12, 10, 0, 178, -42, 52, 1, -2];
MemFit(errors, model);

% Error histogram:   -180 _________.'_.________ +180
%           Model:   Standard mixture model with bias
%      Parameters:   mu, g, sd
% 
% mu: the bias 
% 
%    Running 3 chains...
%    ... not yet converged (200); btw/within variance: 1.97
%    ... not yet converged (400); btw/within variance: 1.41
%    ... not yet converged (600); btw/within variance: 2.26
%    ... not yet converged (800); btw/within variance: 2.11
%    ... not yet converged (1000); btw/within variance: 1.34
%    ... not yet converged (1200); btw/within variance: 1.12
%    ... chains converged after 1400 samples!
%    ... collecting 4500 samples from converged distribution
% 

% This refers to the “chains” of Markov Chain Monte Carlo,  
% Wikipedia (http://en.wikipedia.org/wiki/Markov_chain_Monte_Carlo).  
% The default MCMC algorithm uses multiple chains whose starting values are specified 
% in the model file (and modifiable), and it continues running them until they have 
% converged to a similar range of parameters.

% ...finished. Now let's view the results:
% 
% parameter	MAP estimate	lower CI	upper CI
% ---------	------------	--------	--------
%       mu	       8.714	 -16.322	  26.388
%        g	       0.203	   0.031	   0.729
%       sd	      29.249	   6.619	  67.400

% the maximum a posteriori (MAP) estimates and credible 
% intervals might constitute an answer to your question. 


%% Swaping model
% swap model advocated by Bays, Catalao and Husain (2009), which holds that 
% participants sometimes mistakenly report the value of the other items in the display
% instead of the target item. This model requires not only the errors but 
% also the distances of the non-target items from the target value.  
% the errors and the non-target values, should be bundled together into a structure:
% >> data.errors = [-89, 29, -2, 6, -16 ...
% >> data.distractors = [-10, 2, -100, 163, 42 ...
% the distractor on the first trial was 10 degrees counterclockwise in color space 
% from the target color, and that the observer chose a 
% color 89 degrees counterclockwise of this target color.

clear all;
data = MemDataset(3)
% data = 
% 
%   struct with fields:
% 
%          errors: [1×4000 double]
%     distractors: [2×4000 double]
%               n: [1×4000 double]
%            time: [1×4000 double]

MemFit(data, SwapModel);
% Error histogram:   -180 ________.-'-.________ +180
%           Model:   Swap model
%      Parameters:   g, B, sd
% parameter	MAP estimate	lower CI	upper CI
% ---------	------------	--------	--------
%        g	       0.096	   0.081	   0.116
%        B	       0.109	   0.093	   0.124
%       sd	      23.877	  23.080	  24.657

help SwapModel
%   SwapModel returns a structure for a three-component model
%   with guesses and swaps. Based on Bays, Catalao, & Husain (2009) model.
%   This is an extension of the StandardMixtureModel that allows for
%   observers' misreporting incorrect items.
%   In addition to data.errors, the data struct should include:
%     data.distractors, Row 1: distance of distractor 1 from target
%     ...
%     data.distractors, Row N: distance of distractor N from target

%   data.distractors may contain NaNs. For example, if you have data with
%   different set sizes, data.distractors should contain as many rows as you
%   need for the largest set size, and for displays with smaller set sizes
%   the last several rows can be filled with NaNs.

%% Full list of models
help MemModels

% One component models:
%     AllGuessingModel        - only guessing
%     NoGuessingModel         - just precision, no guessing
%  
%   Mixture models for a single set size:
%     StandardMixtureModel    - guess rate and precision
%     SwapModel               - guess rate, precision and swaps to other items.
%     VariablePrecisionModel  - guess rate and variable precision
%     EnsembleIntegrationModel - integration with distractors shifts reports
%  
%   Models parameterized based on set size:
%     SlotModel               - capacity and precision (no benefit when cap.>setsize)
%     SlotsPlusResourcesModel - capacity and precision (more juice when cap.>setsize)
%     SlotsPlusAveragingModel - capacity and precision (more slots/item when cap.>setsize)
%     ContinuousResourceModel - capacity juice split among all items equally
%  
%   Models that depend on delay duration:
%     ExponentialDecayModel   - capacity K and sd, plus objects drop out over time
%  
%   Model wrappers:
%     WithBias                - adds a bias terms (mu) to any model
%     FixParameterValue       - fix any parameter in a model to a specific value
%     Orientation             - converts a model to use a 180 degree space
%     TwoAFC                  - converts a model so that can be fit to 2afc data
%     WithLapses              - adds inattentional parameter to any model

%% Cleaner plots of the posterior

% Using MCMC means that we are sampling from the posterior rather than evaluating it 
% directly. Thus, even though the true posterior is almost always a smooth function of the 
% parameters, the plots obtained from the standard MemFit call will not always be smooth. 
% We can fix this by using GridSearch rather than MCMC to refine our graph.

clear all;
data = MemDataset(3);
model = StandardMixtureModel();
fit = MemFit(data, model);

fullPosterior = GridSearch(data, model, 'PosteriorSamples', fit.posteriorSamples);
PlotPosterior(fullPosterior, model.paramNames);

% We first fit the data using GridSearch and obtain the posterior. We call this
% fullPosterior, since it came from GridSearch (although in reality it is only 
% proportional to the posterior, it is not the true posterior distribution);
% the results from MCMC we call posteriorSamples. 
% Then we call the plot function PlotPosterior, which takes either a 
% fullPosterior or posteriorSamples as the first parameter, and the names of the 
% model’s parameters as the second parameter. More advanced uses of the MemToolbox 
% will generally require separate calls to the MemFitting and MemPlots functions.

%% VariablePrecisionModel with more parameters
% For more complex models, understanding the distribution from 2-dimensional heatmaps 
% can be challenging. For example, the default VariablePrecisionModel has three 
% parameters, controlling the guess rate (g), the mean of the precision (mnSTD) and the 
% standard deviation of the precision (stdSTD). 
% Let’s fit this to the data from MemDataset(1).
clear all;
data = MemDataset(1);
fit = MemFit(data, VariablePrecisionModel);

% parameter	MAP estimate	lower CI	upper CI
% ---------	------------	--------	--------
%        g	       0.075	   0.063	   0.090
%    mnSTD	      18.049	  17.322	  18.775
%   stdSTD	       6.121	   4.811	   7.074

% all of the parameters are slightly correlated with each other

% This example also gives you a peak at another feature of the MemToolbox – custom 
% model plots. When you call MemFit with the VariablePrecisionModel, it not only creates 
% the graphs you are used to seeing -- the posterior plot, the paralell coordinates plot, and 
% the posterior predictive – it also creates another, fourth plot. This is because the 
% VariablePrecisionModel includes a function called .modelPlot

%  the custom model plot shows the higher-order distribution on precision,
%  with the MAP parameters displayed in solid green and other samples from 
%  the posterior shown with their color indicating their likelihood:

% This helps visualize the meaning of the higher-order parameters. Other models include 
% different custom model plots; for example, the swap model shows a distractor-centered 
% error plot (as in Bays et al. 2009 Figure 2), to allow visualization of whether observers 
% are frequently choosing distractor items.