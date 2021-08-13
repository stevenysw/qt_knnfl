%% generate data
n = 10000;
[X1, X2] = genran(n);
f0 = double((X1 - 0.5).^2 + (X2 - 0.5).^2 <= 2/1000);
y = f0 + trnd(3,1,n);
X = [X1; X2];

%% with lambda = 0.5
lambda = 1;
theta_qt = qt_knn_admm(X, y, 5, lambda, 0.5, 50);
theta_mm = qt_knn_mm(X, y, 5, lambda, 50);
theta_fl = knnfl(X, y, 5, lambda);
mean((f0 - theta_qt).^2)
mean((f0 - theta_mm).^2)
mean((f0 - theta_fl).^2)

%% plot comparison
subplot(1,2,1)
scatter(X1, X2, 14, theta_qt)
set(gca,'fontsize',15)
caxis([0 1])
title("Quantile KNN Predict")

subplot(1,2,2)
scatter(X1, X2, 14, theta_fl)
set(gca,'fontsize',15)
caxis([0 1])
title("KNN-FL Predict")

%% with lambda = 1
lambda = 1;
theta_qt = qt_knn_admm(X, y, 5, lambda, 0.5, 50);
mean((f0 - theta_qt).^2)
theta_fl = knnfl(X, y, 5, lambda);
mean((f0 - theta_fl).^2)

%% plot comparison
subplot(1,2,1)
scatter(X1, X2, 10, theta_qt)
set(gca,'fontsize',14)
caxis([0 1])
title("Quantile KNN Predict")

subplot(1,2,2)
scatter(X1, X2, 10, theta_fl)
set(gca,'fontsize',14)
caxis([0 1])
title("KNN-FL Predict")

%% Monte Carlo
N = 100;
lambda = logspace(-2,2,50);

mse_qt = zeros(1,N);
mse_fl = zeros(1,N);
for i = 1:N
    [X1, X2] = genran(n);
    f0 = double((X1 - 0.5).^2 + (X2 - 0.5).^2 <= 2/1000);
    y = f0 + trnd(3,1,n);
    X = [X1; X2];
    
    for j = 1:length(lambda)
        theta_qt = qt_knn_admm(X, y, 5, lambda(j), 0.5, 50);
        theta_fl = knnfl(X, y, 5, lambda(j));
        mse_1(j) = mean((f0 - theta_qt).^2);
        mse_2(j) = mean((f0 - theta_fl).^2);
    end 
    mse_qt(i) = min(mse_1);
    mse_fl(i) = min(mse_2);
end
mean(mse_qt)
mean(mse_fl)
