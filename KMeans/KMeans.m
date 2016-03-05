% Do not change the function name. You have to write your code here
% you have to submit this function
function segmentedImage = KMeans(featureImageIn, numberofClusters, clusterCentersIn)

    % Get the dimensions of the input feature image
    [M, N, noF] = size(featureImageIn);
    % some initialization
    % if no clusterCentersIn or it is empty, randomize the clusterCentersIn
    % and run kmeans several times and keep the best one
    if (nargin == 3) && (~isempty(clusterCentersIn))
        NofRadomization = 1;
    else
        NofRadomization = 5;    % Should be greater than one
    end

    % ----------------------------------- % 
    % -You have to write your code here-- %
    % ----------------------------------- % 

    [m n c] = size(featureImageIn);
    X = reshape(featureImageIn, m*n, c)';

    min_dist = Inf;
    
    % main
    for i = 1 : NofRadomization    
        [cluster, codebook, distortion] = cvKmeans(X, numberofClusters);
        if distortion < min_dist
            min_dist = distortion;            
            min_cluster = cluster;            
        end
    end
    
    segmentedImage = reshape(min_cluster, m, n) / numberofClusters;   
end


function [Cluster Codebook, distortion] = cvKmeans(X, K, stopIter, distFunc, verbose)
% cvKmeans - K-means clustering
%
% Synopsis
%   [Cluster Codebook] = cvKmeans(X, K, [stopIter], [distFunc], [verbose])
%
% Description
%   K-means clustering
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix representing feature vectors by columns
%                     where D is the number of dimensions and N is the
%                     number of vectors.
%   (scalar) K        The number of clusters.
%   (scalar) [stopIter = .05]
%                     A scalar between [0, 1]. Stop iterations if the
%                     improved rate is less than this threshold value.
%   (func)   [distFunc = @cvEucdist]
%                     A function handle for distance measure. The function
%                     must have two arguments for matrix X and Y. See
%                     cvEucdist.m (Euclidean distance) as a reference.
%   (bool)   [verbose = false]
%                     Show progress or not.
%
% Outputs ([]s are optional)
%   (vector) Cluster  1 x N vector cntaining intergers indicating the
%                     cluster indicies. Cluster(n) is the cluster id for
%                     X(:,n).
%   (matrix) Codebook D x K matrix representing cluster centroids (means)
%                     or VQ codewords (codebook)
%

    if ~exist('stopIter', 'var') || isempty(stopIter)
        stopIter = .05;
    end
    if ~exist('distFunc', 'var') || isempty(distFunc)
        distFunc = @cvEucdist;
    end
    if ~exist('verbose', 'var') || isempty(verbose)
        verbose = false;
    end
    [D N] = size(X);
    if K > N,
        error('K must be less than or equal to the number of vectors N');
    end

    % Initial centroids
    Codebook = X(:, randsample(N, K));

    improvedRatio = Inf;
    distortion = Inf;
    iter = 0;
    while true
        % Calculate euclidean distances between each sample and each centroid
        d = distFunc(Codebook, X);
        % Assign each sample to the nearest codeword (centroid)
        [dataNearClusterDist, Cluster] = min(d, [], 1);
        % distortion. If centroids are unchanged, distortion is also unchanged.
        % smaller distortion is better
        old_distortion = distortion;
        distortion = mean(dataNearClusterDist);

        % If no more improved, break;
        improvedRatio = 1 - (distortion / old_distortion);
        if verbose
            fprintf('%d: improved ratio = %f\n', iter, improvedRatio);
        end
        iter = iter + 1;
        if improvedRatio <= stopIter, break, end;

        % Renew Codebook
        for i=1:K
            % Get the id of samples which were clusterd into cluster i.
            idx = find(Cluster == i);
            % Calculate centroid of each cluter, and replace Codebook
            Codebook(:, i) = mean(X(:, idx),2);
        end
    end

end

function d = cvEucdist(X, Y)
    if ~exist('Y', 'var') || isempty(Y)
        %% Y = zeros(size(X, 1), 1);
        U = ones(size(X, 1), 1);
        d = abs(X'.^2*U).'; return;
    end
    V = ~isnan(X); X(~V) = 0; % V = ones(D, N); 
    U = ~isnan(Y); Y(~U) = 0; % U = ones(D, P); 
    d = abs(X'.^2*U - 2*X'*Y + V'*Y.^2);
end

