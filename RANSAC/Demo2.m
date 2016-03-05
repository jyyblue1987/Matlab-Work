% ----------------------------------- % 
% ------ Do not modify this code ---- %
% ------ Do not submit this code ---- %
% ----------------------------------- % 
% close all
clear all
clc
inIM = imread('line.jpg');
inIM = double(inIM);
inIM = (inIM(:,:,1) + inIM(:,:,2) + inIM(:,:,3))/3;
[M, N] = size(inIM);

edgeImageIn = edge(inIM, 'canny');
figure, imshow(edgeImageIn), title ('input')

noIter = 1e4; % total number of iterations that 2 points are selected at random
fitDistance = 0.6; % min distance of a point to a line to be considered as "on the line"
noPts = 150; % min number of votes that each line should get
minD = 30;  % minimum allowed distance between pairs (in pixels). To improve line fitting
% lines = RansacLine(edgeImageIn,150,fitDistance,0.99);
lines = RansacLine(edgeImageIn, noIter, fitDistance, noPts, minD);
figure, imshow(edgeImageIn), title ('output')
for ii = 1 : size(lines, 1)
    % display line equation
    display(['line #' num2str(ii) ': ' num2str(lines(ii,1)) 'X + '...
        num2str(lines(ii,2)) 'Y = ' num2str(lines(ii,3))]);
    
    % draw the lines
    p_top = round((1 - lines(ii,2))/lines(ii,1));
    p_bot = round((1 - N*lines(ii,2))/lines(ii,1));
    line([1 N],[p_top p_bot],'Color','r','LineWidth',1)
end

