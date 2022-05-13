%% Fitting orientation data
% Sometimes you may wish to use continuous report data on dimensions 
% that span only 180 degrees. For example, oriented lines that do not 
% have a preferred direction. MemToolbox supports this via the 
% Orientation() wrapper function. In particular, for such data you should 
% specify your .errors as ranging from -90 to 90, rather than -180 to 180, 
% and then wrap your chosen model in Orientation() before calling any of
% the fitting functions:
% If you specify data that appears to be orientation data, but the model you include is not 
% wrapped with the Orientation() wrapper function, MemFit will not automatically detect 
% this error

clear all;
data.errors = [-12 3 38 27 -29 21 -22 52 -2 -19 21 17 38 6 34 25 44];
% This will fit a model that wraps from -90 to 90 degrees, and will adjust the first and third 
% parameters of the model to account for this wrapping. These parameters have values in 
% degrees, and so must be adjusted to account for the different wrapping . The model will 
% have “(for orientation)” added to the end of its name
MemFit(data, Orientation(WithBias(StandardMixtureModel), [1,3]))

