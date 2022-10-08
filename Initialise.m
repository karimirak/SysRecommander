function [u, v] = Initialise(X , r, init)
    [m,n] = size(X);
    f = 1;
%   rng(110)
    switch string(init)
        % Init.1: Random
        case {'rnd', 'random'}
            u = randn(m,r) * f;  
            v = randn(n,r) * f;  
           
        % Init.2: Ones
        case {'ones'}
            u = ones(m, r);
            v = ones(n, r); 
              
        % Init.3: average per row 
        case {'avg', 'average'}
            v = ones(n,r) * f;
            u = zeros(m,r);
            for i = 1 : m
                u(i,:) = mean(X(i,X(i,:)>0)) / r;  % moyenne des notes dans la matrice X
            end
            u=u.*f;
       
        % Init.4: SVD
        case {'svd'}
            [s,v,d] = svds(X, r);
            u = s*v .*f;
            v = d .*f;  
    end  
    u = u ./ (repmat(sum(u), m, 1)) ; 
    v = v ./ (repmat(sum(v), n, 1)) ; 
end