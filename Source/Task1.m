
close all
clear all
clc
% Read and display an image
load BrainWeb
figure(1), imshow(I), title('origin image')
% input of min_threshold and max_threshold 
% default value of min_threshold = 0.03 
% default value of max_threshold = 0.07
%min_threshold = input('input min threshold: default value = 0.03\n');
%max_threshold = input('input max threshold: default value = 0.07\n');

min_threshold = 0.03;
max_threshold = 0.07;

%%%%%%% Canny edge detection for sigma 1 %%%%%%%%%%
sigma = 1;
[mag1,dir1] = EdgeFilter(I, sigma);
figure(2), imshow(mag1/max(mag1(:))), title('scale 1, EdgeFilter')

nonmax_supp1 = NonMaximalSuppression(mag1,dir1,sigma);
figure(3), imshow(nonmax_supp1/max(nonmax_supp1(:))), title('scale 1, NonMaximalSuppression')

bin1 = HysteresisThreshold(nonmax_supp1,min_threshold, max_threshold, sigma);
figure(4), imshow(bin1), title('scale 1, HysteresisThreshold');

display('Press any key to continue')
pause

%%%%%%% Canny edge detection for sigma 2 %%%%%%%%%%
sigma = 2;
[mag2,dir2] = EdgeFilter(I, sigma);
figure(5), imshow(mag2/max(mag2(:))), title('scale 2, EdgeFilter')
nonmax_supp2 = NonMaximalSuppression(mag2,dir2,sigma);
figure(6), imshow(nonmax_supp2/max(nonmax_supp2(:))), title('scale 2, NonMaximalSuppression')
bin2 = HysteresisThreshold(nonmax_supp2,min_threshold, max_threshold,sigma);
figure(7), imshow(bin2), title('scale 2, HysteresisThreshold');

display('Press any key to continue')
pause

%%%%%%% Canny edge detection for sigma 4 %%%%%%%%%%
sigma = 4;
[mag4,dir4] = EdgeFilter(I, sigma);
figure(8), imshow(mag4/max(mag4(:))), title('scale 4, EdgeFilter')
newmag4 = NonMaximalSuppression(mag4,dir4,sigma);
figure(9), imshow(newmag4/max(newmag4(:))), title('scale 4, NonMaximalSuppression')
bin4 = HysteresisThreshold(newmag4,min_threshold, max_threshold,sigma);
figure(10), imshow(bin4), title('scale 4, HysteresisThreshold');

display('Press any key to continue')
pause

%%%%%%% Canny edge detection for sigma 8 %%%%%%%%%%
sigma = 8;
[mag8,dir8] = EdgeFilter(I, sigma);
figure(11), imshow(mag8/max(mag8(:))), title('scale 8, EdgeFilter')
newmag8 = NonMaximalSuppression(mag8,dir8,sigma);
figure(12), imshow(newmag8/max(newmag8(:))), title('scale 8, NonMaximalSuppression')
bin8 = HysteresisThreshold(newmag8,min_threshold, max_threshold,sigma);
figure(13), imshow(bin8), title('scale 8, HysteresisThreshold');