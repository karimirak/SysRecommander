function Save_csv(u, v, filename, mu, a ,b)
    load Data/inputEval;
    numpred = size(Eval,1); 
    predic = zeros(numpred,2); 
    predic(:,1) = 1:numpred; 
    
    if nargin > 3
         for i = 1 : numpred
            predic(i,2) = mu + a(Eval(i,1)) + b(Eval(i,2)) + u(Eval(i,1),:) * v(Eval(i,2), :)'; 
            predic(i,2) = max(1, predic(i,2)); 
            predic(i,2) = min(5, predic(i,2)); 
        end
    else
         for i = 1 : numpred
            predic(i,2) = u(Eval(i,1),:) * v(Eval(i,2), :)'; 
            %Make sure the prediciton is in [1,5]
            predic(i,2) = max(1, predic(i,2)); 
            predic(i,2) = min(5, predic(i,2)); 
        end
    end 
    
    hdr = 'ID,Rating';
    dlmwrite(filename, hdr, '')
    dlmwrite(filename,predic,'-append','precision',7);
end


