function [u, v, eu1, ev1] = GradientDescentLrFixe(X, W, u, v, lr)
    % Update U
    R = (X-u*v');
    WR = W.*R;   
    gradU = - 2 * WR*v; % + 2*lambda*u;
    unew = u - lr * gradU;
    eu1 = LossFct(X, W, unew, v); 
    u=unew;
   
    %%Update V       
    R = (X-unew*v');
    WR = W.*R;
    gradV = - 2 * WR'*unew; %+ 2*lambda*v;
    vnew = v - lr * gradV;
    ev1 = LossFct(X, W, unew, vnew); 
    v=vnew;
end