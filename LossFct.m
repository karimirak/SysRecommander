function [err] = LossFct(X, W, u, v , mu, a, b)
    
    % Predictions
    Xpred = u*v';
       
    % Residual : error
    if nargin < 5      
        R = (X - Xpred);
    else        
        R = (X - mu - a(:) - b(:)' - Xpred); 
    end
    
    % Mask
        WR = W.*R;
    % Errpr
        err = sum(sum(WR.^2)); 
    % rmse = sqrt(err/numX);
end