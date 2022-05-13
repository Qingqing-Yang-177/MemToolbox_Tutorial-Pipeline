%% Fitting models that require data from multiple set sizes
% Several of the models in the MemToolbox fit data across multiple set sizes with a 
% likelihood function that depends on the number of items on the display. For example, the 
% slots+averaging model of Zhang and Luck (2008) postulates that there are a fixed 
% number of memory slots available to observers, and thus is committed to the idea that 
% the guess rate and standard deviation should be predictable across set size, based on 
% the number of slots present and the amount of information contained in a slot. To use 
% such models, you must provide a data struct that contains a set size field, n. This field 
% says, for each trial, how many items were present
     
clear all;
data = MemDataset(10)
data
% 2 or 5
MemFit(data, SlotsPlusAveragingModel)

% parameter	MAP estimate	lower CI	upper CI
% ---------	------------	--------	--------
% capacity	       2.982	   2.692	   3.257
%       sd	      19.701	  18.345	  21.262

% The standard plotting functions of the MemToolbox are useful in this case, but, by virtue 
% of the fact that they plot all of the data together (collapsing across set size), they do not 
% provide the best visualizations of this kind of data. Rather than asking if the model fits 
% the average data across all of the set sizes, it is often more informative to look at the fits 
% and model residuals for each set size individually.

% For this reason, all of the plotting functions of the MemToolbox which depend on the 
% data create figures that have an additional menu added to them, labeled MemToolbox
% This menu allows you to limit the data being shown to a particular set
% size.

% the SlotsPlusAveragingModel correctly predicts all of the data, and the data when limited
% to just set size 2, and the data when limited to just set size 5. If you fit the same data 
% with the StandardMixtureModel, it would fit total data OK, but would fail to fit the set sizes 
% properly (since it would use the same parameters for every set size).