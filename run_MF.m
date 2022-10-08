clear all; 
clc;
%% Add Algorithms folder to path.
addpath(pwd);
cd Algorithms/;
addpath(genpath(pwd));
cd ..;

%% Load data matrix  
load Data/inputX; load Data/csv/ratings_given.csv;  ratings = ratings_given;
% load Data/inputXsm;load Data/csv/ratings_sm.csv;  ratings = ratings_sm;

 %% Parameters
 alg = "SGD";               % L'algorithme     : 'GD' - 'SGD' - 'ALS'
 init = 'svd';              % L'initialisation : 'random' - 'ones' - 'average' - 'svd'
 biais = true;              % biais : true / false
 lambda = 0.025;            % paramétre de régularisation
 NMF = false;               % NMF : true / false
 lr = 0.002;                % pas d'apprentissage : leranin rate
 iter = +inf;               % Nombre d'itérations maximum
 rank = 6; 
 
 %% Rmse Evolution 
  tic
  [epoch,U,V, train_rmse, valid_rmse] = MatrixFacto(X,ratings, init, rank, lambda, iter, alg, lr, biais, NMF);
  time(rank) = toc;  
 %% Output and visualisation
 legend_list = [];
 figure
 if biais 
    alg = strcat(alg, '-b');
 end
  fprintf('Init :%s - rank : %d - lambda :%d - Epoch : %d - Time : %f   - Train_RMSE: %f - Valid_RMSE: %f \n',...
           init,      rank,       lambda,      epoch,       time(rank)/60, train_rmse(end),   valid_rmse(end))
  filename = strcat(alg,'_Init-', string(init), '_lambda-',string(lambda),'_iter',string(epoch));
  legend_list = full([legend_list ; rank]);
  PlotRmse(train_rmse, rank, alg, init, filename, lambda, legend_list, valid_rmse)
  