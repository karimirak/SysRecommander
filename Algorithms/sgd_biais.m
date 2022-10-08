function [U, V, mu, a, b] = sgd_biais(data, U, V, lambda, lr, mu, a, b, NMF)   
    N = length(data);  % nbr observations
    perm = randperm(N); % shuffle    
    
    for n=1:N
        user = data(perm(n),1);
        movie = data(perm(n),2);
        rating = data(perm(n),3);
        
        Xpred = mu + a(user) + b(movie) + U(user,:) * V(movie,:)';
        resid = rating - Xpred;
        
        %% update U
        gradU = -2 * resid.* V(movie,:) + 2 * lambda .* U(user,:);
        U(user,:) = U(user,:) - lr * gradU;
        if NMF
            U(user,:) = U(user,:) .* (U(user,:)>0);
        end

                
        %% Update V
        gradV = -2 * resid.* U(user,:) + 2 * lambda .* V(movie,:);
        V(movie,:) = V(movie,:) - lr * gradV;
        if NMF
            V(movie,:) = V(movie,:) .* (V(movie,:)>0);
        end   
        
        %% Update biais 
%         lambda=0;
        a(user)  = a(user)  + 2 * lr * (resid - lambda * a(user));
        b(movie) = b(movie) + 2 * lr * (resid - lambda * b(movie));
%         lambda = 0.02;
    end       
end
