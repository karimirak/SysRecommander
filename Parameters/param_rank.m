%% Rank
 clear all; 
 clc;
 
 addpath(pwd);
cd Algorithms/;
addpath(genpath(pwd));
cd ..;
 %% Load data matrix 
 load Data/inputX; load Data/csv/ratings_given.csv;  ratings = ratings_given;
% load Data/inputXsm;load Data/csv/ratings_sm.csv;  ratings = ratings_sm;

 %% Parameters
 alg = "SGD";               % 'GD' - 'SGD' - 'ALS'
 init = 'rnd'; 
 biais = true;
 lambda = 0.02;
 lr = 0.002; 
 iter = 40;
 NMF = false;
 figure

train = []; valid = [];
for rank = 1:5
    tic
    [train_rmse,i,U,V, valid_rmse] = MatrixFacto(X, ratings, init, rank, lambda, iter, alg, lr, biais,NMF);
    time = toc;
    fprintf('Init :%s - rank : %d - lambda :%d - Iter : %d - Time : %f - RMSE: %f - RMSE: %f \n', init, rank, lambda, i, time/60, train_rmse(end), valid_rmse(end) )
    % Evolution RMSE par rapport au paramétre de régularisation
    train = full([train; train_rmse(end)]);
    valid = full([valid; valid_rmse(end)]);
end
    plot(train, 'b')
    hold on
    plot(valid, 'r')
    legend('train' , 'valid')
