 clear all; 
 clc;
 addpath(pwd);
cd Algorithms/;
addpath(genpath(pwd));
cd ..;
 %% Load data matrix 
%load Data/inputX; load Data/csv/ratings_given.csv;  ratings = ratings_given;
load Data/inputXsm;load Data/csv/ratings_sm.csv;  ratings = ratings_sm;

 %% Parameters
 alg = "GD";               % 'GD' - 'SGD' - 'ALS'
 init = 'svd';           % 'random' - 'ones' - 'average' - 'svd'
 biais = false;              % biais : true / false
 lambda = 0;            % paramétre de régularisation
 NMF = false;               % NMF : true / false
 lr = 0.001;                % pas d'apprentissage : leranin rate
 iter = 150;               % Nombre d'itérations maximum
 rank = 2; 


 figure
 legend_list=[];
% Learning Rate
for lr = 0.01:0.01:.1
    [epoch,U,V, train_rmse, valid_rmse] = MatrixFacto(X,ratings, init, rank, lambda, iter, alg, lr, biais, NMF);
    rmse = train_rmse(end);
    time(rank) = toc;
    fprintf('Init :%s - rank : %d - lambda :%d - Iter : %d - Time : %f - RMSE: %f \n', init, rank, lambda, epoch, time(rank)/60, rmse)
    filename = strcat('Alg-',alg,'_Init-', string(init), '_lambda-',string(lambda));
    % Evolution RMSE par rapport au pas (learning rate) 
    legend_list = full([legend_list ; lr]);
    
    plot(train_rmse)
    hold on
    title('Root Mean Squared Error vs Iterations',...
        strcat('Algorithm : ',alg, ' - Init : ',string(init), ' - rank : ', string(rank)),...
        'Color','blue');
    xlabel('Iterations');
    ylabel('Root Mean Squared Error (RMSE)');
    param_legend = [];
    for i = 1 : length(legend_list)
        param = legend_list(i);
        param_legend = [param_legend , strcat('lr : ', string(param))];
    end 
    legend(cellstr(param_legend));
end


    %% Fixed Learning Rate 
    %figure
     %% Mask
%     W = X; 
%     W(W>0) = 1;
%     numX = sum(sum(X>0));
%     [U, V, eu1, ev1] = GradientDescentLrFixe(X,W, U, V, lr);
%     if eu1 == NaN || eu1 > 10000
%         eu1 = 10000;
%     end
%     if ev1 == NaN || ev1 > 100
%         ev1 = 10000;
%     end
%     % Evolution RMSE par rapport au pas (learning rate) 
%     train_rmse = full([train_rmse; sqrt(eu1/numX) ]);         
%     
%     legend_list = full([legend_list ; lr]);
%     
%     plot(train_rmse)
%     hold on
%     title('Root Mean Squared Error vs Iterations',...
%         strcat('Algorithm : ',alg, ' - Init : ',string(init), ' - rank : ', string(rank)),...
%         'Color','blue');
%     xlabel('Iterations');
%     ylabel('Root Mean Squared Error (RMSE)');
%     param_legend = [];
%     for i = 1 : length(legend_list)
%         param = legend_list(i);
%         param_legend = [param_legend , strcat('lr : ', string(param))];
%     end 
%     legend(cellstr(param_legend));

     