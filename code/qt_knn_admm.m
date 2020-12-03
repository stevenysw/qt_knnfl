function [theta, iter] = qt_knn_admm(X, y, K, lambda, tau, Niter)
    n = length(y);
    theta = y;
    z = y;
    u = zeros(1,n);
    
    R = 0.5;
    
    Id1 = nearestneighbour(X, 'num', K)';
    Id2 = repmat(1:n, 1, K);
    edge = [Id1(:) Id2(:)];
    data = repmat([0 0], [length(edge),1]) - edge;
    dist = sqrt(data(:,1).^2 + data(:,2).^2);
    [c,ia,ib] = unique(dist);
    edgeunique = edge(ia,:);
    edgeunique = sort(edgeunique, 2);
    
    for iter = 1:Niter
        theta_prev = theta;
        
        %%%% updata theta
        aux = y - z + u;
        ind1 = find(aux > (tau/R));
        ind2 = find(aux < ((tau-1)/R));
        
        theta = y;
        aux = z - u;
        theta(ind1) = aux(ind1) + tau/R;
        theta(ind2) = aux(ind2) + (tau-1)/R;
        
        %%%% update z 
        z = graphtv((theta + u)', edgeunique(:,1), edgeunique(:,2), lambda/R)';
        
        %%%% update u
        u = u + theta - z;
        
        if (norm(theta - theta_prev, 2) < 1e-4) & (iter > 10)
            break
        end
    end
end