% ----------------------------------- % 
% ------ Do not modify this code ---- %
% ------ Do not submit this code ---- %
% ----------------------------------- % 
clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%% 1) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read and display an image
load T1_T2_PD.mat
figure, 
subplot(1,3,1), imshow(t1)
subplot(1,3,2), imshow(t2)
subplot(1,3,3), imshow(pd)
%%%%%%%%%%%%%%%%%%%%%%%%% 2) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apply KMeans, the features are t1 t2 pd
% clusterCentersIn = [1 1 1; 1 1 0; 1 0 1; 0 1 1; 1 0 0; 0 1 0; 0 0 1; 0 0 0];
InIm = zeros([size(t1) 3]); % input image that includes all t1 t2 pd data
InIm(:,:,1) = t1;
InIm(:,:,2) = t2;
InIm(:,:,3) = pd;
segmentedImage = KMeans(InIm,8);%,clusterCentersIn);
figure, imshow(segmentedImage), colormap hot
title('KMeans with t1 t2 pd');


%%%%%%%%%%%%%%%%%%%%%%%%% 3) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create two new images that encode the x and y coordinates of 
% each pixel in the image.
Ximage = repmat( [1:size(InIm,2)], size(InIm,1), 1);
Yimage = repmat( [1:size(InIm,1)]', 1, size(InIm,2));

%%%%%%%%%%%%%%%%%%%%%%%%% 4) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normalize and add to features
FeatureIin = zeros( size(InIm,1), size(InIm,2), 5);
FeatureIin(:,:,1:3) = InIm;
FeatureIin(:,:,4) = Ximage/max(Ximage(:));
FeatureIin(:,:,5) = Yimage/max(Yimage(:));

%%%%%%%%%%%%%%%%%%%%%%%%% 5) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apply Kmeans to new feature image
segmentedImage = KMeans(FeatureIin,8);%,clusterCentersIn);
figure, imshow(segmentedImage)
title('KMeans with t1 t2 pd X Y');
display('Finished!'), colormap hot
