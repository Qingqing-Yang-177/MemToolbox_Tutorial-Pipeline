%% Multiple Subjects
% When aggregating results from multiple subjects we typically fit a model separately to 
% the data from each subject. To do so in MemToolbox, pass multiple datasets to MemFit

%% Fit multiple subjects independently
% The toolbox also provides two helper functions that provide an
% alternative route to fitting data from multiple participants. The
% FitMultipleSubjects_MAP function computes the MAP estimate for each
% subject and then also calculates means and standard errors for each 
% parameter for you; there is a similar FitMultipleSubject_MLE function 
% calculates maximum likelihood parameters rather than maximum a posterior
% parameters (i.e., it does not consider the prior at all).

datasets{1} = MemDataset(1);
datasets{2} = MemDataset(2);
model = StandardMixtureModel();
fit = MemFit(datasets, model)

% Or:
% for i=1:length(datasets)
%   fit{i} = MemFit(datasets{i}, model);
% end

%% Fit multiple subjects hierarchically
% fitting a single hierarchical model of all the subjects together. 
% This treats each of the subjects' parameters as samples from a 
% normally-distributed population and uses the data to infer the population
% mean and SD of each parameter, plus the best fit subject-specific parameters.

datasets{1} = MemDataset(1);
datasets{2} = MemDataset(2);
model = StandardMixtureModel();
fit = MemFit(datasets, model, 'UseHierarchical', true)

%% Fit multiple subjects hierarchically with the Hierarchical model wrapper function directly. 
data = {MemDataset(1), MemDataset(2), MemDataset(3)};
hModel = Hierarchical(data, StandardMixtureModel());
params = MAP(data, hModel);

% The parameters are “flattened” into a single vector to fit the model; to get back 
% parameters for each subject and for the group mean and group standard deviation, you 
% will want to use the OrganizeHierarchicalParams function:

fit = OrganizeHierarchicalParams(hModel, params);

%Or MLE function, or MCMC on it.

% The parameters are “flattened” into a single vector to fit the model; to get back 
% parameters for each subject and for the group mean and group standard deviation, you 
% will want to use the OrganizeHierarchicalParams function:

% This workflow is what is done by MemFit when UseHierarchical is set to
% true：
% calling Hierarchical() with the model and data, 
% then fitting it with MAP, 
% and then converting the parameters back to understandable fits 

%% Compare the parameters across conditions within the hierarchical modeling

% Often it is desirable to compare parameters across conditions to determine whether the 
% population mean in one condition is different than the population mean in another 
% condition. Within the hierarchical modeling framework, this question can be addressed 
% by simply testing whether the posteriors for the means of the populations overlap for the 
% two conditions.
% To ask about the uncertainty in parameters, we have to use MCMC on the 
% hierarchical model. Using MCMCSummarize, we can then get the upper and 
% lower credible intervals for each parameter’s mean.

posteriorSamples = MCMC(data, hModel);
lowerCredible = MCMCSummarize(posteriorSamples, 'lowerCredible');
upperCredible = MCMCSummarize(posteriorSamples, 'upperCredible');

lowerMean = OrganizeHierarchicalParams(hModel, lowerCredible)
% lowerMean = 
%  paramsSubs: [3x2 double]
%  paramsStd: [0.0286 2.3228]
%  paramsMean: [0.0152 14.1632]
upperMean = OrganizeHierarchicalParams(hModel, upperCredible)
% upperMean = 
%  paramsSubs: [3x2 double]
%  paramsStd: [0.5417 24.5397]
%  paramsMean: [0.3389 38.4790]

% Thus, for example, the 95% credible interval on guess rate for the population 
% (paramsMean) lies between 0.0152 and 0.3389. By comparing these values across 
% conditions' guess rate, we can examine whether there are reliable differences 
% in a particular parameter.

% e.g. compare the parameter induced by dataset condition 1
posteriorSamples = MCMC(data{1}, hModel);
lowerCredible = MCMCSummarize(posteriorSamples, 'lowerCredible');
upperCredible = MCMCSummarize(posteriorSamples, 'upperCredible');
lowerMean = OrganizeHierarchicalParams(hModel, lowerCredible)
upperMean = OrganizeHierarchicalParams(hModel, upperCredible)
