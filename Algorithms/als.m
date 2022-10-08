function [U, V] = als(X, U, rank, lambda)    
    % UPDATE V
    V = ((U'*U) + lambda * eye(rank)) \ U' * X ;
    V = V .* (V>0);

    %  UPDATE U
    U = (((V*V') + lambda * eye(rank)) \ V * X')' ;
    U = ((U>0) .* U); 

    % normalize U columns to unit
    m = size(X,1);
    U = U ./ (repmat(sum(U), m, 1)+eps) ; 
    
    %Xpred= U * V;
end