function [train, valid] = splitTrainValid(X, pourcentage)

m = size(X,1);

idx = randperm(m)  ;

train = X(idx(1:round(pourcentage*m)),:) ; 

valid = X(idx(round(pourcentage*m)+1:end),:) ;

end
