classdef LabelBinarizer < BaseEstimator & TransformerMixin
    % Binarize labels in a one-vs-all fashion.
    %
    % https://github.com/steven2358/sklearn-matlab
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        neg_label = 0;
        pos_label = 1;
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        classes_; % Holds the label for each class.
    end
    
    methods
        % constructor
        function obj = LabelBinarizer(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % Fit label binarizer.
        function fit(obj,X,~)
            C = unique(X);
            obj.classes_ = C;
        end
        
        % Transform multi-class labels to binary labels. Returns an array
        % of shape [n_samples, n_features_new].
        function X_new = transform(obj,X)
            n_samples = length(X);
            n_features = length(obj.classes_);
            X_new = obj.neg_label*ones(n_samples,n_features);
            for i=1:n_samples
                X_new(i,ismember(obj.classes_,X(i))) = obj.pos_label;
            end
        end
        
        % Transform binary labels back to multi-class labels
        function X_orig = inverse_transform(obj,X)
            n_samples = size(X,1);
            X_orig = zeros(n_samples,1);
            for i=1:n_samples
                X_orig(i) = obj.classes_(ismember(X(i,:),obj.pos_label));
            end
        end
    end
end
