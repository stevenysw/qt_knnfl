function [theta, iter] = qt_knn_mm(X, y, K, lambda, Niter)
    n = length(y);
    theta = repmat(median(y),1,n);
    
    eps = 1e-4;
    
    %%%% KNN 
    Id1 = nearestneighbour(X, 'num', K)';
    Id2 = repmat(1:n, 1, K);
    edge = [Id1(:) Id2(:)];
    data = repmat([0 0], [length(edge),1]) - edge;
    dist = sqrt(data(:,1).^2 + data(:,2).^2);
    [c,ia,ib] = unique(dist);
    edgeunique = edge(ia,:);
    edgeunique = sort(edgeunique, 2);
    num_edge = length(edgeunique);

    %%%% sparse D
    i_indices = [1:num_edge  1:num_edge];
    j_indices = [edgeunique(:,1)  edgeunique(:,2) ];
    val =  [ones(1,num_edge) -ones(1, num_edge)];
    D = sparse( i_indices,j_indices,val,num_edge,n);
    
    for iter = 1:Niter
        theta_prev = theta;
        
        w1 = 1./(abs(y - theta_prev)+eps);
        w1 = sparse(1:n,1:n, min(5,w1),n,n);
        w2 =1./((abs(theta_prev(edgeunique(:,1)) - theta_prev(edgeunique(:,2))))+eps);
        w2 = sparse(1:num_edge,1:num_edge, min(5,w2),num_edge,num_edge);
        
        A= w1+lambda*D'*w2*w2*D;
        b= w1*y';
        theta = A\b;
        theta = theta';
                
        if (norm(theta - theta_prev, 2) < 1e-4) & (iter > 10)
            break
        end
    end
end