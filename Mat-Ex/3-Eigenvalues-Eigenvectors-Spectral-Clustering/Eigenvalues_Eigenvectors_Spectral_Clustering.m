%%% Spectral clustering example:
clear variables
close all
clc

%% First example: Spectral clustering vs KMeasn clustering
% We take three "blobs" of scattered data on the plane.
% This example shows that the three clusters are already well separated
% We implement from scratch, step by step, the procedure to compute the
% spectral clustering. We will show that distance-based clustering 
% should work well already (like K-means) without the "spectral procedure"

% 1. Generate some random points on the 2D plane
rng('default'); % For reproducibility

n = 100; 
X = [randn(n,2)*0.5+3;
    randn(n,2)*0.5
    randn(n,2)*0.5-3]; 

%2. Plot them:
figure();
tiledlayout(1,3);
nexttile;
scatter(X(:,1),X(:,2),'b');
title('Input data');

%3. Construct the similarity matrix based on the Euclidean distance ^2
% returns the Euclidean distance between pairs of observations in X.
dist_temp = pdist(X); 

% Create a square matrix from a pairwise distance vector of length.
% The resulting matrix will be symmetric matrix with zeros along the diagonal.
dist = squareform(dist_temp);

% We update the adjacency matrix to weight the edges between points by
% "pairwise similarity". In realtity, we compute exp(-(dist/sigma).^2),
% where sigma is some scaling factor; here we assume equal to 1.
S = exp(-dist.^2);

%4. Check that is symmetric:
issymmetric(S)

%5. Construct the "degree matrix" Dg such that Dg(ii) = sum i-th row of S:
[~,m] = size(S);

d = zeros(1,m);
for i = 1:m
    d(i) = sum(S(i,:));
end

Dg = diag(d); % create a diagonal matrix with d diagonal elements

%6. Construct the unnormaized Laplacian matrix L = Dg-S;
L = Dg-S;

%7. Compute eigenvalues and eigenvectors of L:
% returns diagonal matrix Eg of eigenvalues and 
% matrix V whose columns are the corresponding  eigenvectors
[V, Eg] = eig(L);

%8. Select the smallest eigenvalues to identify the number of clusters k:
eg = diag(Eg); % extract diagonal elements, that are the eigenvalues
index = eg(eg<1); % select the eigenvalues < 1
k = length(index); % count the number of eigenvalues 

%9. Apply a clustering algorithm like Kmeans on the first k columns of the
% Eigenvector matrix V:
idx = kmeans(V(:,1:k),k);

%10. Visualize the obtained "labels".
nexttile;
gscatter(X(:,1),X(:,2),idx);
title('Spectral clustering')

nexttile;
idx2 = kmeans(X, k);
gscatter(X(:,1),X(:,2),idx2);
title('Kmeans only')

%% Second example: more difficult. 
% The generated points are not belong to two clusters, but the structure 
% in the Euclidean space is not well separated. 
% Hence, a different basis is needed. For this purpose it is fundamental 
% to use the eigenvectors of the Laplacian matrix.

%1. Generate noisy data
N = 300;  % Size of each cluster
r1 = 2;   % Radius of first circle
r2 = 4;   % Radius of second circle
theta = linspace(0,2*pi,N)';

X1 = r1*[cos(theta),sin(theta)]+ rand(N,1); 
X2 = r2*[cos(theta),sin(theta)]+ rand(N,1);
X = [X1;X2]; % Noisy 2-D circular data set

%2. Plot them:
figure();
tiledlayout(1,3);
nexttile
scatter(X(:,1),X(:,2),'b');
title('Input data');

%3. Apply the classical distance-based clustering (kmeans)
% we can check that it doesn't work since the data are not well-separated
% in the euclian space.
idx2 = kmeans(X,2);
nexttile;
gscatter(X(:,1),X(:,2), idx2);
title('Kmeans clustering')

%4. Apply a spectral clustering
[idx,V2] = spectralcluster(X,2);
nexttile
gscatter(X(:,1),X(:,2),idx);
title('Spectral clustering')

% Plot the eigenvectors basis
figure()
scatter(V2(:,1), V2(:,2),'ob','filled')
title('Eigenvectors basis')