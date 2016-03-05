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

% main
nColor = numberofClusters;
[cluster, codebook] = cvKmeans(X, nColor);
for i=1:size(codebook, 2)
    idx = find(cluster == i);
    Xvq(:,idx) = repmat(codebook(:,i), 1, length(idx));
end

segmentedImage = reshape(Xvq', m, n, c);

