function [ cost ] = rmse( Xpred, X )
    resid = Xpred(:) - X(:);
    cost = sqrt(mean(resid.^2));
end