function [U, V] = sgd(data, U, V, lambda, lr, NMF)
    N=size(data,1);     % nbr observations
    perm = randperm(N); % shuffle
        
    for n=1:N
        user = data(perm(n),1);
        movie = data(perm(n),2);
        rating = data(perm(n),3);
        
        resid = rating -  U(user,:) * V(movie,:)';
        
        % update U
        gradU = -2 * resid.* V(movie,:) + 2 * lambda .* U(user,:);
        U(user,:) = U(user,:) - lr * gradU;
        if NMF
            U(user,:) = U(user,:) .* (U(user,:)>0);
        end
        
        resid = rating -  U(user,:) * V(movie,:)';
        % Update V
        gradV = -2 * resid.* U(user,:) + 2 * lambda .* V(movie,:);
        V(movie,:) = V(movie,:) - lr*gradV;
        if NMF
            V(movie,:) = V(movie,:) .* (V(movie,:)>0);
        end
    end   