function [theta] = knnfl(X, y, K, lambda)
    n = length(y);
    
    %%%% KNN incidence
    Id1 = nearestneighbour(X, 'num', K)';
    Id2 = repmat(1:n, 1, K);
    edge = [Id1(:) Id2(:)];
    data = repmat([0 0], [length(edge),1]) - edge;
    dist = sqrt(data(:,1).^2 + data(:,2).^2);
    [c,ia,ib] = unique(dist);
    edgeunique = edge(ia,:);
    edgeunique = sort(edgeunique, 2);
    
    theta = graphtv(y', edgeunique(:,1), edgeunique(:,2), lambda)';
end
