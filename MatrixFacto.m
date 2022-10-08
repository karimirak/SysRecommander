function [epoch, U , V, train_rmse, valid_rmse] = MatrixFacto(X,ratings_data, init, rank, lambda, iter, alg, lr, biais, NMF)  
    %% Data
    [m, n] = size(X); 
    numX = sum(sum(X>0));
    
    %% Mask
    W = X; 
    W(W>0) = 1;
       
    %% initialisation : [random , ones , average , svd]
    [U, V] = Initialise(X, rank, string(init));
    
    % Initialisation biases    
     mu = sum(sum(X))/ sum(sum(W));        % ratings average mu = mean(train_ratings);     
     moyUsers = sum(X')./(sum(W'));
     moyUsers(isnan(moyUsers)) = 0;     
     moyMov = sum(X)./(sum(W));
     moyMov(isnan(moyMov)) = 0; 
%      a = moyUsers' - mu;      % User biases 
%      b = moyMov' - mu ;       % Movie biases 
     rng(110);  
     a  = randn(m,1) ;  b  = randn(n,1) ;  % plus rapide 
                 
    %% Minimise Cost Algorithm  
    epoch = 1;
    train_rmse = []; valid_rmse = [];   
    stepu = []; stepv = [];
    switch alg           
        % Gradien Descent
        case 'GD'             
            while epoch <= iter && (epoch <= 3 || (train_rmse(end-2)-train_rmse(end))/train_rmse(end-2) > 1e-6)
                 if biais
                    [U, V, stepu, stepv, e, mu, a , b] = GradientDescent_biais(X,W, U, V, stepu, stepv, lambda, mu, a, b, NMF);           
                else
                    [U, V, stepu, stepv, e] = GradientDescent(X, W, U, V, stepu, stepv, lambda, NMF);           
                end                
                train_rmse = full([train_rmse; sqrt(e/numX) ]);                
                fprintf('Iter %d; Train_RMSE: %f \n', epoch, train_rmse(end));
                epoch = epoch +1;
            end
                
       % Stochastic Gradien Descent
       case 'SGD'  
            [train, valid] = splitTrainValid(ratings_data, 1);
            train_users = train(:,1);    valid_users = valid(:,1);
            train_movies = train(:,2);   valid_movies = valid(:,2);
            train_ratings = train(:,3);  valid_ratings = valid(:,3);
            while epoch <= iter && (epoch <= 2 || ((train_rmse(end-1)-train_rmse(end))/train_rmse(end-1)) > 1e-6)
                if biais
                    [U, V, mu, a, b] = sgd_biais(train, U, V, lambda, lr, mu, a, b, NMF); 
                     train_pred = predict(train_users, train_movies, U, V, mu, a, b);
                     valid_pred = predict(valid_users, valid_movies, U, V, mu, a, b);                     
                else
                    [U, V] = sgd(train, U, V, lambda, lr, NMF);
                     train_pred = predict(train_users, train_movies, U, V);
                     valid_pred = predict(valid_users, valid_movies, U, V);
                end
                train_rmse= full([train_rmse; rmse(train_pred, train_ratings)]);
                valid_rmse= full([valid_rmse; rmse(valid_pred, valid_ratings)]);              
                fprintf('Iter %d; Train_RMSE: %f ; Valid_RMSE: %f \n', epoch, train_rmse(end), valid_rmse(end) );
                epoch = epoch +1;
            end    
      % ALS
      case 'ALS'
            % remplacer 0 par moy des films et moy users
            X2 = X + (1-W).*(moyMov); 
            while (epoch < 50)  %&& (epoch <= 2 || (train_rmse(end-1)-train_rmse(end))/train_rmse(end-1) > 1e-6)
                [U, V] = als(X2,U, rank, lambda); 
                e = sum(sum((X - U*V).^2)); 
                train_rmse= full([train_rmse;  sqrt(e/numX)]);                            
                fprintf('Iter %d; RMSE: %f \n', epoch, train_rmse(end));               
                epoch = epoch + 1;                
            end
            V=V';  
    end
     if length(valid_rmse) == 0
          valid_rmse = [NaN];
      end
    %% Save File
    if biais 
        filename = strcat(alg,'b', '_Init-',string(init), '_rank-',string(rank), '_iter-',string(epoch),'.csv');
         Save_csv(U,V, filename, mu, a, b)  
    else
        filename = strcat(alg, '_Init-',string(init), '_rank-',string(rank), '_iter-',string(epoch),'.csv');         Save_csv(U,V, filename)    
    end    
end
