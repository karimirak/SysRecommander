function PlotRmse(train_rmse, rank, alg, init, filename, lambda, legend_list, valid_rmse)  
    
%   iterations = [1:1:size(e,1)];
    plot(train_rmse)
    hold on
    title('Root Mean Squared Error vs Iterations',...
        strcat('Algorithm : ',alg, ' - Init : ',string(init), ' - rank : ', string(rank)),...
        'Color','blue');
    xlabel('Epochs');
    ylabel('Root Mean Squared Error (RMSE)');
    
%     param_legend = [];
%     for i = 1 : length(legend_list)
%         param = legend_list(i);
%         param_legend = [param_legend , strcat('lambda : ', string(param))];
%     end 
%     legend(cellstr(param_legend));

    if nargin > 7 && length(valid_rmse(valid_rmse>0)) > 0
        plot(valid_rmse , 'r--')
        legend('train', 'validation')
    end
    grid 
    savefig(strcat(filename,'.fig'))
end