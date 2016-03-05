% Do not change the function name. You have to write your code here
% you have to submit this function
function lines = RansacLine(edgeImageIn, noIter, fitDistance, noPts, minD)


% get the image size
[M, N] = size(edgeImageIn);
% Get coordinates of all of the pixel locations corresponding to an edge
edgeInd = find(edgeImageIn);
[eIi, eIj] = ind2sub([M N], edgeInd);

% ----------------------------------- % 
% -You have to write your code here-- %
% ----------------------------------- % 

pts2 = [eIj, eIi];
pts3 = transpose(pts2);

thDist = fitDistance * (M + N) / 2;
thInlrRatio = .1;
[t,r] = ransac(pts3,noIter,thDist,thInlrRatio);

lines(1,1) = cos(t);
lines(1,2) = sin(t);
lines(1,3) = tan(t) * r;
