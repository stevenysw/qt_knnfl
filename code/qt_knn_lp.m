function [theta] = qt_knn_lp(X, y, K, lambda, tau)
    n = length(X);
    
    %%%% KNN incidence
    Id1 = nearestneighbour(X, 'num', K)';
    Id2 = repmat(1:n, 1, K);
    edge = [Id1(:) Id2(:)];
    data = repmat([0 0], [length(edge),1]) - edge;
    dist = sqrt(data(:,1).^2 + data(:,2).^2);
    [c,ia,ib] = unique(dist);
    edgeunique = edge(ia,:);
    edgeunique = sort(edgeunique, 2);
    num_edge = length(edgeunique);
    
    %%%% first two inequalities on theta
    i_ind = [1:n (1+n):(2*n)];
    j_ind = [1:n 1:n];
    val = [-tau*ones(1,n) -(tau-1)*ones(1,n)];
 
    %%%% first two inequalities on u
    i_ind = [i_ind 1:n (n+1):(2*n)];
    j_ind = [j_ind (n+1):(2*n) (n+1):(2*n)];
    val = [val -ones(1,n) -ones(1,n)];

    %%%% third inequality on theta
    i_ind = [i_ind (2*n+1):(2*n+num_edge)];
    j_ind = [j_ind edgeunique(:,1)'];
    val = [val ones(1,num_edge)];
 
    i_ind = [i_ind (2*n+1):(2*n+num_edge)];
    j_ind = [j_ind edgeunique(:,2)'];
    val = [val -ones(1,num_edge)];
 
    %%%% third inequality on v
    i_ind = [i_ind (2*n+1):(2*n+num_edge)];
    j_ind = [j_ind (2*n+1):(2*n+num_edge)];
    val = [val -ones(1,num_edge)];

    %%% fourth inequality on theta
    i_ind = [i_ind (2*n+num_edge+1):(2*n+2*num_edge)];
    j_ind = [j_ind edgeunique(:,1)'];
    val = [val -ones(1,num_edge)];

    i_ind = [i_ind (2*n+num_edge+1):(2*n+2*num_edge)];
    j_ind = [j_ind edgeunique(:,2)'];
    val = [val ones(1,num_edge)];

    %%%% fourth inequality on v
    i_ind = [i_ind (2*n+num_edge+1):(2*n+2*num_edge)];
    j_ind = [j_ind (2*n+1):(2*n+num_edge)];
    val = [val -ones(1,num_edge)];

    %%%% LP
    A = sparse(i_ind,j_ind,val,2*n+2*num_edge,2*n+num_edge);
    b = [-tau*y -(tau-1)*y zeros(1,num_edge) zeros(1,num_edge)];
    f = [zeros(1,n) ones(1,n) lambda*ones(1,num_edge)]';
    theta = linprog(f,A,b);
    theta = theta(1:n)';
end
 