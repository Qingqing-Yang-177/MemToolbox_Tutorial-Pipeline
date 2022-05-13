%% Picking up a model
% A full listing of available models can be found by
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


%% Model Comparison
clear all;
data = MemDataset(1);

% First model:
model1 = StandardMixtureModel();
MemFit(data,model1);

%  it looks like the model overestimates counterclockwise error and 
% underestimates clockwise errors. This particular subject had a clockwise-bias in their 
% responses, and the StandardMixtureModel is always centered around zero. To fix this, 
% we can use a different model. In particular, we can use the StandardMixtureModel model, 
% but allow a bias parameter to shift the model’s center point by using the WithBias 
% wrapper function.

% Second model:
model2 = WithBias(StandardMixtureModel);
MemFit(data,model2);

% Now compare:
MemFit(data, {model1, model2});

% MemToolbox compares the models using six different metrics, including the log 
% likelihood, AIC, AICc, BIC, Bayes factor (and posterior odds of the models) and DIC. It 
% also provides (brief) ideas of what direction is preferable for each metric.


% You've chosen to compare the following models:
% 
%         Model 1:   Standard mixture model
%      Parameters:   g, sd
% 
%         Model 2:   Standard mixture model with bias
%      Parameters:   mu, g, sd
% 
% Computing log likelihood, AIC, AICc and BIC...
% 
% The log likelihood of the parameters given the
% data.
% 
% model  	Log likelihood
% -----  	--------------
%  1     -14429.61
%  2     -14396.70
% 1:2  	 -32.91
% Preferred model: 2 (Standard mixture model with bias)
% 
% The Akaike Information Criterion is a measure of
% goodness of fit that includes a penalty term for
% each additional model parameter. Lower AIC denotes
% a better fit. To compare models A:B, look at the
% difference AIC(A) - AIC(B). Positive values
% provide evidence in favor of model B, negative in
% favor of model A.
% 
% model  	AIC
% -----  	---
%  1     28863.23
%  2     28799.41
% 1:2  	63.82
% Preferred model: 2 (Standard mixture model with bias)
% 
% The corrected Aikaike Information is the same as
% the AIC, but it includes a correction for finite
% data. It can be interpreted in the same way.
% 
% model  	AICc
% -----  	----
%  1     28863.23
%  2     28799.42
% 1:2  	63.81
% Preferred model: 2 (Standard mixture model with bias)
% 
% The Bayesian Information Criterion is similar to
% AIC, with different assumptions about the prior of
% models, and thus a more stringent penalty for more
% complex models. It can be interpreted in the same
% way.
% 
% model  	BIC
% -----  	---
%  1     28878.99
%  2     28823.06
% 1:2  	55.93
% Preferred model: 2 (Standard mixture model with bias)


%% Comparing 2 models by DIC:
% type y when asked.
% - Sampling from model 1: Standard mixture model
% - Sampling from model 2: Standard mixture model with bias
% 
% The Deviance Information Criterion is a
% generalization of the AIC and BIC that includes a
% penalty for the effective number of parameters,
% estimated from the dispersion in the posterior of
% the models.
% 
% model  	DIC
% -----  	---
%  1     28863.31
%  2     28799.13
% 1:2  	64.18
% Preferred model: 2 (Standard mixture model with bias)
