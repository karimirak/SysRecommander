function [u, v, stepu, stepv, e, mu, a, b] = GradientDescent_biais(X, W, u, v, stepu, stepv, lambda, mu, a, b, NMF)
    % Update U
    R = X - mu - a(:) - b(:)' - u*v';
    WR = W.*R;   
    gradU = - 2 * WR*v + 2 * lambda*u;
    
    if isempty(stepu) % initial stepsize 
        stepu = norm(u)/norm(gradU); 
    end  
    e0 =  LossFct(X, W, u, v,  mu, a, b);
    e = +Inf;
    
    while e > e0
        unew = u - stepu * gradU;
        if NMF
            unew = unew .* (unew>0);
        end
        stepu = stepu/3;  
        e = LossFct(X, W, unew, v, mu, a, b); 
    end
    stepu = stepu * 4;
    u=unew;
   
    %% Update V 
         
    R = X - mu - a(:) - b(:)' - unew*v';
    WR = W.*R;
    gradV = - 2 * WR'*unew + 2*lambda*v;
   
    
    if isempty(stepv) % initial stepsize 
        stepv =  norm(v)/norm(gradV);
    end
   
    e0 = LossFct(X, W, unew, v,  mu, a, b);
    e = +Inf;   
 
    while e > e0     
        vnew = v - stepv * gradV;
        if NMF
            vnew = vnew .* (vnew>0);
        end
        stepv = stepv/3;
        e = LossFct(X, W, unew, vnew,  mu, a, b);
    end
       
    v=vnew;    
    
    lr = 0.0001;
    a = a + lr * sum(WR')';
    b = b + lr * sum(WR)';
       
    stepv = stepv * 4; 
   
end