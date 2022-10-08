function [predictions] = predict(user, movie, U, V, mu, a, b)
predictions = size(user,1);

    if nargin > 5                   % with bias
        for n=1:size(user,1)
            i = user(n) ;
            j = movie(n);
            predictions(n)= mu + a(i) + b(j) + U(i,:) * V(j,:)'; 
        end
    else
        for n=1:size(user,1)
            i = user(n) ;
            j = movie(n);
            predictions(n)= U(i,:) * V(j,:)'; 
        end
    end
end


