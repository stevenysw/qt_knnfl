# Citation
Steven Siwei Ye and Oscar Hernan Madrid Padilla. *Non-parametric quantile regression via the K-NN fused lasso.* **Journal of Machine Learning Research, Vol. 22, No. 111, 1-38, 2021.**

# Codes
*  linear programming 
*  ADMM and ADMM with BIC model selection
*  Majorize-Minimize
*  K-NN fused lasso

Note that all algorithms require the usage of nearestneighbour.m by Richard Brown. See details in https://www.mathworks.com/matlabcentral/fileexchange/12574-nearestneighbour-m.

For ADMM, we use parametric max-flow algorithm from "On Total Variation Minimization and Surface Evolution Using Parametric Maximum Flows" by Antonin Chambolle and Jérôme Darbon (https://link.springer.com/article/10.1007/s11263-009-0238-9). Users need to compile "TVexact" first to enable the "graphtv" function.

# Datasets 
*  California housing data
*  Chicago crime data

# Demo
*  comparison between quantile K-NN fused lasso and K-NN fused lasso
