function testRansac

clear all
clc


outlrRatio = .4;

inIM = imread('line.jpg');

figure, imshow(inIM), title ('input'),hold on

inIM = double(inIM);
inIM = (inIM(:,:,1) + inIM(:,:,2) + inIM(:,:,3))/3;
[M, N] = size(inIM);

edgeImageIn = edge(inIM, 'canny');

% get the image size
[M, N] = size(edgeImageIn);
% Get coordinates of all of the pixel locations corresponding to an edge
edgeInd = find(edgeImageIn);
[eIi, eIj] = ind2sub([M N], edgeInd);

pts2 = [eIj, eIi];
pts3 = transpose(pts2);
iterNum = 300;
thDist = 100;
thInlrRatio = .1;
[t,r] = ransac(pts3,iterNum,thDist,thInlrRatio);
k1 = -tan(t);
b1 = r/cos(t);

X = 0:N;

plot(X,k1*X+b1,'r')

end

function err = sqrError(k,b,pts)
%	Calculate the square error of the fit

theta = atan(-k);
n = [cos(theta),-sin(theta)];
pt1 = [0;b];
err = sqrt(sum((n*(pts-repmat(pt1,1,size(pts,2)))).^2));

end