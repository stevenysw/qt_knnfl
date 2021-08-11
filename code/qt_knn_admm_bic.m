function [theta_opt] = qt_knn_admm_bic(X, y, K, tau, Niter, lambda)
    %%%% lambda is a vector of values here
    
    n = length(y);
    
    sigma = (1 - abs(1-2*tau)) / 2;
    
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
    
    i_indices = [1:num_edge  1:num_edge];
    j_indices = [edgeunique(:,1)  edgeunique(:,2) ];
    val =  [ones(1,num_edge) -ones(1, num_edge)];
    D = sparse(i_indices,j_indices,val,num_edge,n);
    
    theta = zeros(length(lambda),n);
    bic = zeros(1,length(lambda));
    for j = 1:length(lambda)
        theta(j,:) =  qt_knn_admm(X, y, K, lambda(j), tau, Niter);

        r = y - theta(j,:);
        idx = find(abs(D*theta(j,:)') < 1e-1);
        conn_edge = edgeunique(idx,:);
        G_conn = graph(conn_edge(:,1), conn_edge(:,2));
        [bin, binsize] = conncomp(G_conn); 
        
        v = sum(binsize > 1);
        like = dot(r,tau-double(r < 0));
        bic(j) = 2/sigma*like + v*log(n);
    end

    idx_opt = max(find(bic == min(bic)));
    theta_opt = theta(idx_opt,:);
end
