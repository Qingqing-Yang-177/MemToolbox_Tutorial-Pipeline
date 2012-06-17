function fullPosterior = GridSearch(data, model, varargin)
  args = struct('MleParams', [], 'PosteriorSamples', [], ...
    ... % Default to 5000 total points
    'PointsPerParam', round(nthroot(5000, length(model.paramNames)))); 
  args = parseargs(varargin, args);
  
  if ~isempty(args.PosteriorSamples)
      % Refine the grid search to look only at reasonable values: 
      model.upperbound = max(args.PosteriorSamples.vals);
      model.lowerbound = min(args.PosteriorSamples.vals);
  end
  
  % Use MLE parameters to center the grid search if any parameters have Inf
  % upper or lowerbound
  if isempty(args.MleParams) && (any(isinf(model.upperbound)) || any(isinf(model.lowerbound))) 
    args.MleParams = MLE(data, model);
  end
  
  % Number of parameters
  Nparams = length(model.paramNames);
  
  % Figure out what values to search
  which = linspace(0,1,args.PointsPerParam);
  for i=1:Nparams
    if ~isinf(model.upperbound(i))
      MappingFunction{i} = @(percent) (model.lowerbound(i) ...
        + (model.upperbound(i)-model.lowerbound(i))*percent);
    else
      if isinf(model.lowerbound(i))
        error('Can''t have lower and upperbound of a parameter be Inf');
      else
        MappingFunction{i} = @(percent) (-log(1-(percent./1.01))*args.MleParams(i)*2);
      end
    end
    valuesUsed{i} = MappingFunction{i}(which);
  end
  
  % Convert to full factorial
  [allVals{1:Nparams}] = ndgrid(valuesUsed{:});
  
  % Evaluate
  logLikeMatrix = zeros(size(allVals{1}));
  parfor i=1:numel(allVals{1})
    curParams = num2cell(cellfun(@(x)x(i), allVals));
    logLikeMatrix(i) = sum(log(model.pdf(data, curParams{:})));
  end
  fullPosterior.logLikeMatrix = logLikeMatrix;
  
  % Convert log likelihood matrix into likelihood, avoiding underflow
  fullPosterior.likeMatrix = exp(logLikeMatrix-max(logLikeMatrix(:)));
  fullPosterior.likeMatrix(isnan(fullPosterior.likeMatrix)) = 0;
  
  % Store values used:
  fullPosterior.valuesUsed = valuesUsed;
end
