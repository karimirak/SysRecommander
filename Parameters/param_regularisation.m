%% Regularization parameter : Lambda
 clear all; 
 clc;
 %% Load data matrix 
%  load inputXsm;load ratings_sm.csv;  ratings = ratings_sm; 
  load inputX; load ratings_given.csv;  ratings = ratings_given;

 %% Parameters
 alg = "SGD";             % 'GD' - 'SGD' - 'SGD-b' - 'ALS'
 init = 'random';         
 lr = 0.002; 
 iter = 100;
 figure

% Regularization Lambda
rank = 5;
tab_lambda=[];
for i = 0:0.001:0.02
    tab_lambda = [tab_lambda; i];
end
for i = 0.025:0.05:1.5
    tab_lambda = [tab_lambda; i];
end

 train = []; valid = [];
for i = 1:length(tab_lambda)
    lambda = tab_lambda(i);
    tic
    [train_rmse,i,U,V, valid_rmse] = MatrixFacto(X, ratings, init, rank, lambda, iter, alg, lr);
    time = toc;
    fprintf('Init :%s - rank : %d - lambda :%d - Iter : %d - Time : %f - RMSE: %f - RMSE: %f \n', init, rank, lambda, i, time/60, train_rmse(end), valid_rmse(end) )
    % Evolution RMSE par rapport au paramétre de régularisation
    train = full([train; train_rmse(end)]);
    valid = full([valid; valid_rmse(end)]);
end
    plot(tab_lambda, train, 'b')
    hold on
    plot(tab_lambda, valid, 'r')
    legend('train' , 'valid')
