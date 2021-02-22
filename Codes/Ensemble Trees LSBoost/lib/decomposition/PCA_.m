classdef PCA_ < BaseEstimator & TransformerMixin
    % Principal component analysis (PCA).
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        n_components = 2; % Number of components to keep.
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        components; % Principal axes in feature space.
    end
    
    methods
        % constructor
        function obj = PCA_(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % Fit the model with X.
        function fit(obj,X,~)
            obj.components = pca(X,'NumComponents',obj.n_components);
        end
        
        % Apply the dimensionality reduction on X.
        function X_new = transform(obj,X)
            X_new = X*obj.components;
        end
    end
end
