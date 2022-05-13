%% Fitting 2AFC, or change detection data
% Except for the continuous report data, two-alternative forced-choice
% tasks are also supported by Memtoolbox
% For example, 3 item in 3 locations with 3 colors, 1 location cued, asked
% to pick which of the two colors the item at cued location was.
% To make use of such data, we can specify data.changeSize and data.afcCorrect 
% rather than data.errors. 
% data.changeSize indicates the difference between the 2 test items, in degrees; 
% data.afcCorrect indicates whether the observer got the trial correct (1) or incorrect (0). 

clear all;
data.changeSize = [180 180 180 180 180 180 20 20 20 20 20 20];
data.afcCorrect = [1 1 1 1 1 1 0 0 0 1 1 1];

% we sometimes test observers with a very distant color (exactly the opposite 
% side of the color wheel), and observers get 100% of these trials correct; 
% and we sometimes test observers with a relatively close color (20 degrees 
% away on the color wheel), and observers get exactly 50% of those trials correct:

MemFit(data);

%% TwoAFC() warpper function
% The MemToolbox supports converting any model to a 2AFC model using the TwoAFC()
% wrapper function. Thus, to make a model for a 2AFC task with a SwapModel, you could 
% use TwoAFC(SwapModel) as your model. However, for models that depend on information 
% about particular displays (like the swap model), the 2AFC wrapper is somewhat slow, 
% since it must compute the likelihood for each display separately.

TwoAFC(SwapModel)