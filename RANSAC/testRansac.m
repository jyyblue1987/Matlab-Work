function testRansac

clear all
clc

inIM = imread('line.jpg');
inIM = double(inIM);
inIM = (inIM(:,:,1) + inIM(:,:,2) + inIM(:,:,3))/3;
[M, N] = size(inIM);

edgeImageIn = edge(inIM, 'canny');
figure, imshow(edgeImageIn), title ('input'),hold on

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

lines(1) = 1 / b1;
lines(2) = -k1 / b1;
lines(3) = 1;

for ii = 1 : size(lines, 1)
    % display line equation
    display(['line #' num2str(ii) ': ' num2str(lines(ii,1)) 'X + '...
        num2str(lines(ii,2)) 'Y = ' num2str(lines(ii,3))]);
    
    % draw the lines
    p_top = round((1 - lines(ii,2))/lines(ii,1));
    p_bot = round((1 - N*lines(ii,2))/lines(ii,1));
    line([1 N],[p_top p_bot],'Color','g','LineWidth',1)
end

end
