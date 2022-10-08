function [u, v, stepu, stepv, e] = GradientDescent(X, W, u, v, stepu, stepv, lambda, NMF)
    %% Update U
    %----------
    R = (X-u*v');
    WR = W.*R;   
    gradU = - 2 * WR*v + 2*lambda*u;
    
    if isempty(stepu) % initial stepsize 
        stepu = norm(u)/norm(gradU); 
    end  
    e0 =  LossFct(X, W, u, v);   %  e0 =  LossFct2(X, W, u*v');
    e1 = +Inf;
    
    while e1 > e0
        unew = u - stepu * gradU;
        if NMF
            unew = unew .* (unew>0);
        end
        stepu = stepu/3;  
      e1 = LossFct(X, W, unew, v);     %         e1 =  LossFct2(X, W, unew*v');
    end
    stepu = stepu * 4;
    u=unew;
   

    %% Update V
    %-----------
    R = (X-unew*v');
    WR = W.*R;
    gradV = - 2 * WR'*unew + 2*lambda*v;
    if isempty(stepv) % initial stepsize 
        stepv =  norm(v)/norm(gradV);
    end
    
    e0 = LossFct(X, W, unew, v);%     e0 =  LossFct2(X, W, unew * v');
    e = +Inf;   
 
    while e > e0     
      vnew = v - stepv * gradV;
      if NMF
            vnew = vnew .* (vnew>0);
      end
      stepv = stepv/3;
      e = LossFct(X, W, unew, vnew);%       e =  LossFct2(X, W, unew * vnew');
    end
    stepv = stepv * 4;  
    v=vnew;
end