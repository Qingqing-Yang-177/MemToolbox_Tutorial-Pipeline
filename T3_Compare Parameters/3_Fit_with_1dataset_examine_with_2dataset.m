%% Fitting a model with one set of data and evaluating it with another
% e.g., fit the models that generalize across set size (e.g.,
% SlotPlusResourcesModel vs ContinuousResourceModel) using only set sizes 1
% and 3, and then ask how well the results generalize to set size 5. To
% facilitate this, the MemToolbox has two functions designed for creating
% “hold-out” sets of data: GetDataByField() and RemoveDataByField(). For
% example, if you have a data struct that contains errors from set sizes 1,
% 3, and 5, and want to fit using only the data from set sizes 1 and 3, you
% might call:
data.errors = [-10, 2, 43, -2, 1, 100, 119, -34, 11];
data.n = [1, 1, 1, 3, 3, 3, 5, 5, 5]
dataWithout5 = RemoveDataByField(data, 'n', 5);
%fit to get posterior distributions:
continuousResourceSamps = MCMC(dataWithout5, ContinuousResourceModel);
slotPlusResourceSamps = MCMC(dataWithout5, SlotsPlusResourcesModel);
% show a posterior predictive distribution for each model for the data from
% set size 5, to examine which provides a better fit:
dataSetSize5 = GetDataByField(data, 'n', 5);
PlotPosteriorPredictiveData(ContinuousResourceModel, continuousResourceSamps, dataSetSize5);
PlotPosteriorPredictiveData(SlotsPlusResourcesModel,slotPlusResourceSamps, dataSetSize5);
