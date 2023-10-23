## MemToolbox Tutorial

This is a tutorial for MATLAB package MemToolbox 1.0.0. 
It contains structured walktrough scripts in order for better novice learning experience, including package setup, modeling, parameter comparison, Fitting. 

#### Intro of MemToolbox
The MemToolbox is a collection of MATLAB functions for modeling visual working memory. In support of its goal to provide a full suite of data
analysis tools, the toolbox includes implementations of popular models of visual working memory, real and simulated data sets, Bayesian and maximum likelihood estimation procedures for fitting models to data,
visualizations of data and fit, validation routines, model comparison metrics, and experiment scripts. The MemToolbox is released under a BSD license and is freely available. The MemToolbox uses semantic versioning (http://semver.org/).

Suchow, J. W., Brady, T. F., Fougnie, D., & Alvarez, G. A. (2013). Modeling visual working memory with the MemToolbox. Journal of Vision, 13(10):9, 1–8. doi:10.1167/13.10.9.
______________________________

#### Contents:
- **MemToolbox**: Memtoolbox package from https://github.com/visionlab/MemToolbox
- **paper.pdf**: a high-level overview of the toolbox from visionlab
- **tutorial.pdf**: a useful walkthrough tutorial of Memtoolbox from visionlab
  
  _my contributions:_
- **T1_Setup**: Install and Setup;
- **T2_Modeling**: Basic Modeling with Continuous data, 2AFC, Orientation data, MultiSetsizes, Model comparison
- **T3_Compare Parameters**: Fit multi subjects/datasets as one pop, or comparing the params btw setsizes/conditions/datasets.
- **T4_Model Fitting**: Compare and fit model by log likelihood, AIC, AICc, BIC, Bayes factor (and posterior odds) and DIC.
- **tutorial_slides.pdf**: A tutorial presentation in Curtislab lab meeting (https://www.clayspacelab.com/lab)

Dependencies:
1. The Statistics Toolbox (http://www.mathworks.com/products/statistics/) is needed for all of the major functionality of the toolbox.
2. The Psychophysics Toolbox (http://psychtoolbox.org) is needed only for the experiment scripts in MemExperiments.
